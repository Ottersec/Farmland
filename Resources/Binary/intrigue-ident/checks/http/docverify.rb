module Intrigue
  module Ident
    module Check
      class Docverify < Intrigue::Ident::Check::Base
        def generate_checks(url)
          [
            {
              type: 'fingerprint',
              category: 'application',
              tags: ['COTS'],
              vendor: 'Docverify',
              product: 'Docverify',
              references: ['https://www.docverify.com/'],
              version: nil,
              description: 'Docverify - Server Header',
              match_logic: :all,
              matches: [
                {
                  match_type: :content_headers,
                  match_content: /^server:\ DocVerify, Inc\.$/i,
                }
              ],
              dynamic_version: lambda { |x|
                                 _first_header_capture(x, /^server:\ DocVerify, Inc\.$/i)
                               },
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
