module Quickbooks
  module Service
    class CreditMemo < BaseService

      def delete(credit_memo)
        delete_by_query_string(credit_memo)
      end

      def pdf(credit_memo)
        url = "#{url_for_resource(model::REST_RESOURCE)}/#{credit_memo.id}/pdf"
        response = do_http_raw_get(url, {}, {'Accept' => 'application/pdf'})
        response.plain_body
      end

      def send(credit_memo, email_address=nil)
        query = email_address.present? ? "?sendTo=#{email_address}" : ""
        url = "#{url_for_resource(model::REST_RESOURCE)}/#{credit_memo.id}/send#{query}"
        response = do_http_post(url, "", {}, { 'Content-Type' => 'application/octet-stream' })
        if response.code.to_i == 200
          model.from_xml(parse_singular_entity_response(model, response.plain_body))
        else
          nil
        end
      end

      private

      def model
        Quickbooks::Model::CreditMemo
      end
    end
  end
end
