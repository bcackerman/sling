(function() {
    if(self.AV)
      return;
    self.AV = {};
    if (!self.JSON)
        self.JSON = {"parse" : function(data) { return eval("(" + data + ")");}};

    var _apiUrl = "http://asyncvoice.labs.ericsson.net/async";
    var _appKey = null;
    var _appName = null;

    var _streamIdentifier = Math.random();
    var _longPollXHR;
    var _hasSession = null;
    var _subscriptions = [];
    var _subscribeTimer = 500;
    var _errorCount = 0;

    /**
    *
    * @class <code>AV</code> is the entry point to the Async Voice API.
    */

    /**
    *
    * @returns {Boolean} true if the current user is logged in to the
    * system, otherwise false.
    */
    AV.hasSession =  function() {
         return _hasSession;
    };

    /**
     * Initialize the Async Voice JavaScript SDK.
     *
     * @param {Object} settings Should contain Application name and key..
     * @param {Function} cb The callback that should be triggered when the
     *                    initialization is done.
     */
    AV.init = function(settings, cb) {
        if (!(settings.apiKey || settings.appKey)) {
            if (cb instanceof Function)
                self.setTimeout(function () { cb({error: true , info:"Application Key missing"});}, 0);
            return;
        }
        _appKey = settings.apiKey ? settings.apiKey : settings.appKey;
        _appName = settings.appName;
        _headRequest("/user/summary.json", function(result) { _hasSession = (result.error == 200); if (cb instanceof Function) cb({info:"Application setup done ok."});});
    };

    /**
     * Request a conversation from the REST API as json.
     *
     * @param {String} conversationIdOrCallback The conversation identifier, could either be the real conversation
     *                 identified as stated in the Atom feed or the identifier
     *                 decided by the developer.
     * @param {Function} cb The callback to trigger when the requested feed .
     *
     * @returns {JSON Object} conversation The requested conversation as argument to the callback
     *						function, if feed does not exist the result will be:
     */
    AV.getConversation = function(conversationIdOrCallback, cb) {
        if ((arguments.length == 1 && conversationIdOrCallback instanceof Function) || !conversationIdOrCallback) {
            var conversationId = self.ASYNC_VOICE_CONVERSATION_NAME ? self.ASYNC_VOICE_CONVERSATION_NAME : document.location.toString();
            var params = "?feed_id="+escape(conversationId)+ "&format=json";
            _getRequest("/conversation/get/"+params, conversationIdOrCallback || cb);
        } else {
            _getRequest("/conversation/get/"+conversationIdOrCallback +".json", cb);
        }
    };

    /**
     * Request information about a user.
     *
     * @param {String} username The username of the user to fetch more information about
     * @param {Function} cb The callback to trigger on result.
     *
     */
    AV.getUser = function(username, cb) {
        _getRequest("/user/get/"+username, cb);
    }


    /**
     * Request information about logged in user.
     *
     * @param {Function} cb The callback to trigger on result.
     *
     */
    AV.getCurrentUser = function(cb) {
        _getRequest("/user/get/", cb);
    }

    /**
     * Set up a long-polling HTTP connection to the Async Voice Server and listen for
     * status updates for the given conversation.
     *
     * @param {Array} conversationIds The conversation identifier, could either be the real conversation
     *                 identified as stated in the Atom conversation or the identifier
     *                 decided by the developer.
     * @param {Function} cb The callback function to call when a new entry has
     *                      been posted to the conversation.
     *                   argument: {JSON Object} update conversation status change
     *
     */
    AV.subscribe = function(conversationIds, cb, params) {
        if (conversationIds && conversationIds instanceof Array) {
            _subscriptions = _subscriptions.concat(conversationIds);
        } else if (conversationIds) {
            _subscriptions.push(conversationIds);
        }
        if (_longPollXHR)
            _longPollXHR.abort();
        var _url = "/conversation/long_poll?id="+_streamIdentifier+"&feed_ids="+escape(_subscriptions)
        if (params)
            _url += "&"+params;
        if (_subscriptions.length > 0)
            _longPollXHR = _getRequest(_url, function(result) { self.setTimeout(function() { AV.subscribe(false, cb, params); }, _subscribeTimer); if (result instanceof Array && result.length > 0) cb(result); });
    };

    /**
     * Unsubscribe to conversation status updates.
     *
     * @param {Array or String} conversationIds The conversationId or conversationIds to unsubscribe to.
     */
    AV.unSubscribe = function(conversationIds) {
        if (conversationIds instanceof String)
            conversationIds = [ conversationIds ];
        for (var i = 0; i < conversationIds.length; i++) {
            for (var j = 0; j < _subscriptions.length; j++) {
                if (conversationIds[i] == _subscriptions[j]) {
                    _subscriptions.splice(j, 1);
                    j--;
                }
            }
        }
        if (_longPollXHR)
            _longPollXHR.abort();
        if (_subscriptions.length < 1 )
            _longPollXHR = null;
    };

    /**
     * Create a new conversation. This requires an authenticated user.
     *
     * @param {String} permission private or public, conversation permissions.
     * @param {String} title The title of the conversation.
     * @param {String} description A short description, max 150 charachters.
     * @param {Function} cb The function to call when the conversation has been created.
     *
     * @returns {JSON Object} conversation The empty conversation as argument to the callback
     *                             function
     */
    AV.createConversation = function(title, description, cb) {
        var conversationId = self.ASYNC_VOICE_CONVERSATION_NAME ? self.ASYNC_VOICE_CONVERSATION_NAME : document.location.toString();
        var params = "?feed_id=" +escape(conversationId) +"&alt_url="+escape(document.location.toString()) +"&alt_title="+escape(_appName)+"&feed_title="+escape(_encode_utf8(title));
        if (!!description)
            params += "&desc="+description.substr(0,150);
        _postRequest("/conversation/create.json"+params,"", function(result) { if (cb instanceof Function) cb(result);});
    };

    /**
     * Create a new entry. This requires an authenticated user.
     *
     * @param {String} conversationId The conversation identifier, could either be the real conversation
     *                 identified as stated in the Atom conversation or the identifier
     *                 decided by the developer.
     * @param {String} title The title of the entry
     * @param {String} summary A summary in text, could contain chat message or
     *                         tags etc.
     * @param {String} position The current position when the entry is created,
     *                          in the format <code>"lat , long"</code>.
     * @param {String} audioData The audio data as a base64 encoded string.
     * @param {Function} cb The function to call when the entry has been created.
     *
     * @returns {JSON Object} conversation The empty conversation as argument to the callback
     *                                     function
     */
    AV.createEntry = function(conversationId, title, summary, position, audioData, cb) {
        var params = "?feed_id=" + escape(conversationId) + "&title=" + escape(_encode_utf8(title)) + "&summary=" + escape(_encode_utf8(summary));
        if (position != ",") params += "&geo=" + position;
        if (audioData!=null) {
            var contentType = audioData.type ? null : "audio/x-wav;base64";
            _putRequest("/conversation/entry/create.json"+params, audioData, contentType, function(result) { if (cb instanceof Function) cb(result);});
        } else
            _getRequest("/conversation/entry/create.json"+params, function(result) { if(cb instanceof Function) cb(result); });
    };

    /**
     * Delete a conversation. This requires an authenticated user. Users can only delete
     * their own conversation from the same application that the conversation was created with.
     * A delete cannot be undone.
     *
     * @param {String} conversationId The conversation identifier.
     * @param {Function} cb The function to call when the conversation has been deleted.
     *
     * @returns {JSON Object} result The result as argument to the callback function.
     */
    AV.deleteConversation = function(conversationId, cb) {
        _postRequest("/conversation/delete/"+conversationId+".json", "", cb);
    };

    /**
     * Delete an entry. This requires an authenticated user. Users can only delete 
     * their own entries. A delete cannot be undone. 
     *
     * @param {String} entryId The entry identifier.
     * @param {Function} cb The function to call when the entry has been deleted.
     *
     * @returns {JSON Object} result The result as argument to the callback function.
     */
    AV.deleteEntry = function(entryId, cb) {
        _postRequest("/conversation/entry/delete/"+entryId+".json", "", cb);
    };

    /**
     * Get the users with a hanging HTTP connection to the given conversation.
     *
     * @param {String} conversationId The conversation identifier, could either be the real conversation
     *                 identified as stated in the Atom conversation or the identifier
     *                 decided by the developer. If null ASYNC_VOICE_CONVERSATION_NAME
     *                 or full url will be used.
     *
     * @param {Function} cb The function to call when the request.
     * 
     * @returns {JSON Object} users The users with a hanging HTTP connection to
     * 							the current conversationId
     */
    AV.getCurrentUsers = function(conversationId, cb) {
        if (!conversationId) {
            var conversationId = self.ASYNC_VOICE_CONVERASATION_NAME ? self.ASYNC_VOICE_CONVERSATION_NAME : document.location.toString();
        }
        _getRequest("/conversation/get_long_poll_users.json?feed_id="+conversationId, cb);
    };

    /**
     * Opens up an iframe that allows a user to do a secure login to Async Voice
     * API server.
     *
     * @param {Function} cb The function to call when the user has logged in or
     * 					canceled the login.
     * 
     * @returns {Boolean} status Returns true if successful login, otherwise
     * 							false.
     */
    AV.login = function(cb) {
        var bodyElem = document.getElementsByTagName("body")[0];
        if (bodyElem.getElementsByClassName("async-login-frame").length > 0)
            return;
        var loginFrame = document.createElement("iframe");
        loginFrame.setAttribute("src", _apiUrl+"/user/login?app_key="+_appKey);
        loginFrame.setAttribute("class","async-login-frame");
        loginFrame.setAttribute("style", "max-width:470px; width:100%; height:350px; position:absolute; left:30%; top:10%; border:solid;border-radius:10px; -webkit-border-radius:10px; -moz-border-radius:10px; -moz-box-shadow: #80cbff 0 0 10px;");
        self.addEventListener("message", function(evt) {
            var v = JSON.parse(evt.data);
            if (v.status == "success") {
                _hasSession = true;

                loginFrame.style.visibility = "hidden";
                bodyElem.removeChild(loginFrame);

                _streamIdentifier++;
                if (_longPollXHR) _longPollXHR.abort();
                if (cb instanceof Function) cb(true);
            } else if(v.status == "cancel") {
                loginFrame.style.visibility = "hidden";
                bodyElem.removeChild(loginFrame);
                if (cb instanceof Function) cb(false);
            } else
                explode();
        }, false);
        bodyElem.appendChild(loginFrame);
    };

    /**
     *Allows the user to log out from the Async Voice server.
     *
     * @param {Function} cb The function to call when the user has logged out.
     */
    AV.logout = function(cb) {
        _getRequest("/user/logout?token"+Math.random(), function() {
            //document.cookie = 'user=Hello; expires=Thu, 01-Jan-70 00:00:01 GMT;';
            _hasSession = null;
            _streamIdentifier++;
            if (_longPollXHR) _longPollXHR.abort();
            if (cb instanceof Function) cb();
        });
    };

    var _putRequest = function(url, data, contentType, cb) {
        _request(url, "PUT", data, contentType, cb);
    };

    var _postRequest = function(url, data, cb) {
        _request(url, "POST", data, null, cb);
    };

    var _getRequest = function(url, cb) {
        return _request(url, "GET", null, null, cb);
    };

    var _headRequest = function(url, cb) {
        _request(url, "HEAD", null, null, cb);
    };
    /**
     * @ignore
     */
    var _request = function(url, method, data, contentType, cb) {
        if (XMLHttpRequest)
            var xhr = new XMLHttpRequest();
        else if (self.XDomainRequest)
            var xhr = new XDomainRequest();
        url += url.indexOf("?") > 0 ? "&" : "?";
        url += "app_key="+_appKey;
        xhr.open(method, _apiUrl+url);
        if (contentType)
            xhr.setRequestHeader("Content-Type", contentType);
        xhr.withCredentials = true;
        /**
         * @ignore
         */
        xhr.onreadystatechange = function () {
            if (xhr.readyState == 4) {
                var status = xhr.status != 0 ? xhr.status : 404;
                var text = xhr.responseText;
                var response = { error: status, text: text };

                if (text) {
                    response = !(text instanceof Object) ? JSON.parse(text) : text;
                }
                if (response.error) {
                    _errorCount++;
                    if (_errorCount >= 5)
                        _subscribeTimer += 300000;
                    _subscribeTimer += 2000;
                } else {
                    _errorCount = 0;
                    _subscribeTimer = 500;
                }
                if (cb instanceof Function) cb(response);
            }
        };
        xhr.send(data);
        return xhr;
    };
    /**
     * @ignore
     */
    var _encode_utf8 = function(s) {
        return unescape(encodeURIComponent(s));
    };

}());

