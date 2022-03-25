module Intrigue
  module Ident
    module Check
      class Varnish < Intrigue::Ident::Check::Base
        def generate_checks(url)
          [
            {
              type: 'fingerprint',
              category: 'application',
              tags: ['Web Server', 'Cache'],
              vendor: 'Varnish-Cache',
              product: 'Varnish',
              website: 'http://www.varnish-cache.org/',
              description: 'Varnish Proxy',
              version: nil,
              match_logic: :all,
              matches: [
                {
                  match_type: :content_headers,
                  match_content: /^server: Varnish$/i,
                }
              ],
              paths: [{ path: url.to_s, follow_redirects: true }],
              inference: false
            },
            {
              type: 'fingerprint',
              category: 'application',
              tags: ['Web Server', 'Cache'],
              vendor: 'Varnish-Cache',
              product: 'Varnish',
              website: 'http://www.varnish-cache.org/',
              description: 'Varnish Proxy',
              version: nil,
              match_logic: :all,
              matches: [
                {
                  match_type: :content_headers,
                  match_content: /^x-varnish:.*$/i,
                }
              ],
              paths: [{ path: url.to_s, follow_redirects: true }],
              inference: false
            },
            {
              type: 'fingerprint',
              category: 'application',
              tags: ['Web Server', 'Cache'],
              vendor: 'Varnish-Cache',
              product: 'Varnish',
              website: 'http://www.varnish-cache.org/',
              description: 'Varnish Proxy',
              version: nil,
              match_logic: :all,
              matches: [
                {
                  match_type: :content_headers,
                  match_content: /^via: (\d+(\.\d+)* )?varnish$/i,
                }
              ],
              # dynamic_version: lambda { |x|
              #  _first_header_capture(x, /^via: (\d+(\.\d+)*) varnish$/i)
              # },
              hide: false,
              paths: [{ path: url.to_s, follow_redirects: true }],
              inference: false
            },
            {
              type: 'fingerprint',
              category: 'application',
              tags: ['Web Server', 'Cache'],
              vendor: 'Varnish-Cache',
              product: 'Varnish',
              website: 'http://www.varnish-cache.org/',
              description: 'Varnish Proxy',
              version: 4,
              match_logic: :all,
              matches: [
                {
                  match_type: :content_headers,
                  match_content: /^via: [0-9.]+ varnish-v4,.*$/i,
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
