class StaticController < ApplicationController 
	@@data
	@@fname
	@@opt
	def index
		@@data = []
		@@fname = ''
		@@opt = ''
	end

	def file_upload 

		data = []
		@@opt = params['merge_type']

		unless params['files'].nil?
			@@fname = params['new_name']
			(params['files'] || []).each do |file|
				s = Roo::Spreadsheet.open(file)
				s.sheets.each do |t|
					temp = []
					first_row = s.sheet(t).first_row
					last_row = s.sheet(t).last_row
					if @@opt == 'separate'
						temp << {title:t}
					else 
						temp << [t]
					end
					(first_row..last_row+1).each do |num|
						temp << s.sheet(t).row(num.to_i)
					end
					data << temp
				end
			end

			@@data = data
			redirect_to static_results_path
		else
			redirect_to root_path
		end

	end

	def results 
		@opt = @@opt
		@dat = @@data
		if @@fname.blank? 
			@@fname = 'new_compiled_sheet'
		end

		@file_name = @@fname

	  respond_to do |format|
	    format.html
	    format.xlsx {
	    	response.headers['Content-Disposition'] = 'attachment; filename="' + @@fname + '.xlsx"'
	    }
	  end
	end
end

