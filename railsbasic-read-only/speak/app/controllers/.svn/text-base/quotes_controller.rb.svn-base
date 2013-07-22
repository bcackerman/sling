class QuotesController < ApplicationController
  before_filter :admin_required
  respond_to :html #:json

  def index
    @quotes = Quote.all
  end

  def new
    @quote = Quote.new
  end

  def edit
    @quote = Quote.find(params[:id])
  end

  def create
    @quote = Quote.new(params[:quote])

    if @quote.save
      redirect_to @quote, notice: 'Quote was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @quote = Quote.find(params[:id])

    if @quote.update_attributes(params[:quote])
      redirect_to @quote, notice: 'Quote was successfully updated.'
    else
      render action: "edit"
    end
  end

end
