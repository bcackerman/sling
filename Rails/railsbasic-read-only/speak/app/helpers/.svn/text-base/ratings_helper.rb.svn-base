module RatingsHelper

  def create_metric_column(post)
    if post.present?

      data_table = GoogleVisualr::DataTable.new
      # Add Column Headers
      data_table.new_column('string', 'Metric' )
      data_table.new_column('number', 'Perfomance')

      if post.category == "Speech"
        evals = Post.show.where(:speech_id => post.id)
        org_count = evals.count
        if org_count == 0
          count = 1
        else
          count = org_count
        end
        evals_overall = 0
        evals_purpose = 0
        evals_organiz = 0
        evals_body = 0
        evals_voice = 0
        evals_humor = 0
        evals_value = 0
        evals_power = 0
        evals.each do |evaluation|
          evals_overall += evaluation.ratings.sum(:overall)
          evals_purpose += evaluation.ratings.sum(:purpose)
          evals_organiz += evaluation.ratings.sum(:organization)
          evals_body += evaluation.ratings.sum(:body)
          evals_voice += evaluation.ratings.sum(:voice)
          evals_humor += evaluation.ratings.sum(:humor)
          evals_value += evaluation.ratings.sum(:value)
          evals_power += evaluation.ratings.sum(:power)
        end
        
        overall = (evals_overall/count).round
        purpose = (evals_purpose/count).round
        organiz = (evals_organiz/count).round
        body = (evals_body/count).round
        voice = (evals_voice/count).round
        humor = (evals_humor/count).round
        value = (evals_value/count).round
        power = (evals_power/count).round
      else
        org_count = post.ratings.count
        if org_count == 0
          count = 1
        else
          count = org_count
        end
        overall = (post.ratings.sum(:overall)/count).round
        purpose = (post.ratings.sum(:purpose)/count).round
        organiz = (post.ratings.sum(:organization)/count).round
        body = (post.ratings.sum(:body)/count).round
        voice = (post.ratings.sum(:voice)/count).round
        humor = (post.ratings.sum(:humor)/count).round
        value = (post.ratings.sum(:value)/count).round
        power = (post.ratings.sum(:power)/count).round
      end

      # Add Rows and Values
      data_table.add_rows([
        ['Overall',       overall],
        ['Purpose',       purpose],
        ['Organization',  organiz],
        ['Body',          body],
        ['Voice',         voice],
        ['Humor',         humor],
        ['Value',         value],
        ['Power',         power]
      ])

      if post.category == "Speech"
        option = { 
          width: 180,
          height: 96,
          title: 'Rating: ' + overall.to_s + ' (total:' + org_count.to_s + ')',
          titleTextStyle: {fontSize: 10},
          tooltip: {textStyle: {fontSize: 10}},
          backgroundColor: '#eee',
          hAxis: {textPosition: 'none'},
          vAxis: {minValue: 0, maxValue: 10, gridlines: {count: 6}}
        }
      elsif post.category == "Evaluation"
        option = { 
          width: 180,
          height: 96,
          title: 'Evaluation Rating: ' + overall.to_s,
          titleTextStyle: {fontSize: 10},
          tooltip: {textStyle: {fontSize: 10}},
          backgroundColor: '#eee',
          hAxis: {textPosition: 'none'},
          vAxis: {minValue: 0, maxValue: 10, gridlines: {count: 6}}
        }
      else #post.category == "Answer"
        option = { 
          width: 180,
          height: 96,
          title: 'Rating: ' + overall.to_s + ' (total:' + org_count.to_s + ')',
          titleTextStyle: {fontSize: 10},
          tooltip: {textStyle: {fontSize: 10}},
          backgroundColor: '#eee',
          hAxis: {textPosition: 'none'},
          vAxis: {minValue: 0, maxValue: 10, gridlines: {count: 6}}
        }
      end
      @metric_col = GoogleVisualr::Interactive::ColumnChart.new(data_table, option)
    end
  end

  def create_metric_bar(post)

    if post.present?
      data_table = GoogleVisualr::DataTable.new
      # Add Column Headers
      data_table.new_column('string', 'Metric' )
      data_table.new_column('number', 'Perfomance')

      if post.category == "Speech"
        evals = Post.show.where(:speech_id => post.id)
        org_count = evals.count
        if org_count == 0
          count = 1
        else
          count = org_count
        end
        evals_overall = 0
        evals_purpose = 0
        evals_organiz = 0
        evals_body = 0
        evals_voice = 0
        evals_humor = 0
        evals_value = 0
        evals_power = 0
        evals.each do |evaluation|
          evals_overall += evaluation.ratings.sum(:overall)
          evals_purpose += evaluation.ratings.sum(:purpose)
          evals_organiz += evaluation.ratings.sum(:organization)
          evals_body += evaluation.ratings.sum(:body)
          evals_voice += evaluation.ratings.sum(:voice)
          evals_humor += evaluation.ratings.sum(:humor)
          evals_value += evaluation.ratings.sum(:value)
          evals_power += evaluation.ratings.sum(:power)
        end
        
        overall = (evals_overall/count).round
        purpose = (evals_purpose/count).round
        organiz = (evals_organiz/count).round
        body = (evals_body/count).round
        voice = (evals_voice/count).round
        humor = (evals_humor/count).round
        value = (evals_value/count).round
        power = (evals_power/count).round
      else
        org_count = post.ratings.count
        if org_count == 0
          count = 1
        else
          count = org_count
        end
        overall = (post.ratings.sum(:overall)/count).round
        purpose = (post.ratings.sum(:purpose)/count).round
        organiz = (post.ratings.sum(:organization)/count).round
        body = (post.ratings.sum(:body)/count).round
        voice = (post.ratings.sum(:voice)/count).round
        humor = (post.ratings.sum(:humor)/count).round
        value = (post.ratings.sum(:value)/count).round
        power = (post.ratings.sum(:power)/count).round
      end

      # Add Rows and Values
      data_table.add_rows([
        ['Overall',       overall],
        ['Purpose',       purpose],
        ['Organization',  organiz],
        ['Body',          body],
        ['Voice',         voice],
        ['Humor',         humor],
        ['Value',         value],
        ['Power',         power]
      ])

      if post.category == "Speech"
        option = { 
          width: 220,
          height: 280,
          title: 'Speech Rating: ' + overall.to_s + ' (total:' + org_count.to_s + ')',
          backgroundColor: '#FAF8CC',
          hAxis: {minValue: 0, maxValue: 10, gridlines: {count: 6}}
        }
      elsif post.category == "Evaluation"
        option = { 
          width: 220,
          height: 280,
          title: 'Evaluation Rating: ' + overall.to_s,
          backgroundColor: '#FAF8CC',
          hAxis: {minValue: 0, maxValue: 10, gridlines: {count: 6}}
        }
      else #post.category == "Answer"
        option = { 
          width: 220,
          height: 280,
          title: 'Answer Rating: ' + overall.to_s + ' (total:' + org_count.to_s + ')',
          backgroundColor: '#FAF8CC',
          hAxis: {minValue: 0, maxValue: 10, gridlines: {count: 6}}
        }
      end
      @metric_bar = GoogleVisualr::Interactive::BarChart.new(data_table, option)
    end
  end

end
