module Intrigue
  module Ident
    module Check
      class MediaWiki < Intrigue::Ident::Check::Base
        def generate_checks(url)
          [
            {
              type: 'fingerprint',
              category: 'application',
              tags: %w[COTS CMS],
              vendor: 'MediaWiki',
              product: 'MediaWiki',
              website: 'https://www.mediawiki.org/wiki/MediaWiki',
              description: 'MediaWiki - Body Match',
              version: nil,
              match_logic: :any,
              matches: [
                {
                  match_type: :content_body,
                  match_content: %r{<a href="//www.mediawiki.org/">Powered by MediaWiki</a>},
                },
                {
                  match_type: :content_body,
                  match_content: /poweredby_mediawiki/,
                }
              ],
              paths: [{ path: url.to_s, follow_redirects: true }],
              inference: false
            },
            {
              type: 'fingerprint',
              category: 'application',
              tags: %w[COTS CMS],
              vendor: 'MediaWiki',
              product: 'MediaWiki',
              website: 'https://www.mediawiki.org/wiki/MediaWiki',
              description: 'generator tag',
              match_logic: :all,
              matches: [
                {
                  match_type: :content_body,
                  match_content: /<meta name="generator" content="MediaWiki/,
                }
              ],
              version: nil,
              dynamic_version: lambda { |x|
                                 _first_body_capture(x, %r{<meta name="generator" content="MediaWiki\ (.*?)"/>})
                               },
              paths: [{ path: url.to_s, follow_redirects: true }],
              inference: true
            }
          ]
        end
      end
    end
  end
end
