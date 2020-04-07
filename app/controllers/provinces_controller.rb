class ProvincesController < InheritedResources::Base

  private

    def province_params
      params.require(:province).permit(:name, :pst, :gst, :hst)
    end

end
