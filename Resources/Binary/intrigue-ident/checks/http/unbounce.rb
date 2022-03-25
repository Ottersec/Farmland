module Intrigue
  module Ident
    module Check
      class Unbounce < Intrigue::Ident::Check::Base
        def generate_checks(url)
          [
            {
              type: 'fingerprint',
              category: 'service',
              tags: ['SaaS', 'Cloud', 'Marketing'],
              vendor: 'Unbounce',
              product: 'Unbounce',
              description: 'missing account string',
              references: [],
              version: nil,
              match_logic: :all,
              matches: [
                {
                  match_type: :content_body,
                  match_content: /The requested URL was not found on this server./i,
                }
              ],
              paths: [{ path: url.to_s, follow_redirects: true }],
              inference: false,
              hide: true
            }
          ]
        end
      end
    end
  end
end
