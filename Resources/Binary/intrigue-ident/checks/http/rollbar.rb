module Intrigue
  module Ident
    module Check
      class Rollbar < Intrigue::Ident::Check::Base
        def generate_checks(url)
          [
            {
              type: 'fingerprint',
              category: 'application',
              tags: ['JavaScript'],
              vendor: 'Rollbar',
              product: 'Rollbarjs',
              website: 'https://rollbar.com/',
              description: 'unique javascript string ',
              version: nil,
              match_logic: :all,
              matches: [
                {
                  match_type: :content_body,
                  match_content: /_rollbarConfig/i,
                }
              ],
              paths: [{ path: url.to_s, follow_redirects: true }],
              inference: false
            }
          ]
        end
      end
    end
  end
end
