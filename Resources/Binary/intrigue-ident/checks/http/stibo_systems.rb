module Intrigue
  module Ident
    module Check
      class StiboSystems < Intrigue::Ident::Check::Base
        def generate_checks(url)
          [
            {
              type: 'fingerprint',
              category: 'application',
              tags: ['Application Server'],
              vendor: 'STIBO Systems',
              product: 'STEP',
              description: 'page title ',
              version: nil,
              references: [],
              match_logic: :all,
              matches: [
                {
                  match_type: :content_title,
                  match_content: /STEP by STIBO Systems/i,
                }
              ],
              dynamic_version: lambda { |x|
                _first_body_capture(x, %r{<span id="versionname">(.*)</span}i)
              },
              dynamic_update: lambda { |x|
                _first_body_capture(x, %r{<span id="versionfull">(.*)</span}i)
              },
              examples: ['<title>winc-prod-azure - STEP by STIBO Systems</title>'],
              paths: [{ path: url.to_s, follow_redirects: true }],
              inference: true  # no CPEs on 20190310
            }
          ]
        end
      end
    end
  end
end
