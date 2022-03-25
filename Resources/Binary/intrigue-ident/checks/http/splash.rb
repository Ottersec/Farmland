module Intrigue
  module Ident
    module Check
      class Splash < Intrigue::Ident::Check::Base
        def generate_checks(url)
          [
            {
              type: 'fingerprint',
              category: 'service',
              tags: %w[Marketing JavaScript SaaS],
              vendor: 'Splash',
              product: 'Splash',
              website: 'https://splashthat.com/',
              description: 'title for default landing page',
              version: nil,
              match_logic: :all,
              matches: [
                {
                  match_type: :content_title,
                  match_content: /Event Marketing Software - Splash/i,
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
