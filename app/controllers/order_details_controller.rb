class OrderDetailsController < InheritedResources::Base

  private

    def order_detail_params
      params.require(:order_detail).permit(:Cards_id, :Order_id, :quantity, :price)
    end

end
