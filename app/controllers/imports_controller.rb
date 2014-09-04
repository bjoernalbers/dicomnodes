class ImportsController < ApplicationController
  def index
  end

  def new
    @import = Import.new
  end

  def create
    # TODO: Add tests!
    @import = Import.new(import_params)
    if @import.valid?
      uploaded_io = import_params[:file]
      filename = 'DICOMNodes.plist'
      File.open(Rails.root.join('public', filename), 'wb') do |file|
        file.write(uploaded_io.read)
      end
      redirect_to imports_path
    else
      render :new
    end
  end

  private

  def import_params
    # TODO: Figure out how to display strong params errors like validation
    # errors (and then reenable strong parameters)!
    #params.require(:import).permit(:file)
    params[:import]
  end
end
