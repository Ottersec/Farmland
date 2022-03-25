module Intrigue
  module Ident
    module Check
      class NiSource < Intrigue::Ident::Check::Base
        def generate_checks(url)
          [
            {
              type: 'fingerprint',
              category: 'service',
              tags: ['Management', 'Web Server'],
              vendor: 'NiSource',
              product: 'NiSource',
              references: ['https://www.nisource.com/'],
              version: nil,
              description: 'NiSource - Server Header',
              match_logic: :all,
              matches: [
                {
                  match_type: :content_headers,
                  match_content: /^server:\ NiSource$/i,
                }
              ],
              hide: false,
              paths: [{ path: url.to_s, follow_redirects: true }],
              inference: false
            }
          ]
        end
      end
    end
  end
end
