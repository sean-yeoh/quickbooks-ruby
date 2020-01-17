module Quickbooks
  module Service
    class PurchaseOrder < BaseService

      def delete(purchase_order)
        delete_by_query_string(purchase_order)
      end

      def pdf(purchase_order)
        url = "#{url_for_resource(model::REST_RESOURCE)}/#{purchase_order.id}/pdf"
        response = do_http_raw_get(url, {}, {'Accept' => 'application/pdf'})
        response.plain_body
      end

    private

      def model
        Quickbooks::Model::PurchaseOrder
      end
    end
  end
end
