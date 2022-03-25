module Intrigue
  module Ident
    module Check
      class BrowserCMS < Intrigue::Ident::Check::Base
        def generate_checks(url)
          [
            {
              type: "fingerprint",
              category: "service",
              tags: ["CMS"],
              vendor: "BrowserMedia",
              product: "BrowserCMS",
              website: "http://browsercms.org/",
              description: "BrowserCMS - generator page reference",
              version: nil,
              match_logic: :all,
              matches: [
                {
                  match_type: :content_body,
                  match_content: /<meta name="generator" content="BrowserCMS/i,
                }
              ],
              dynamic_version: lambda { |x|
                _first_body_capture(x, /<meta name="generator" content="BrowserCMS (\d+(\.\d+)*)/i)
              },
              hide: false,
              paths: [{ path: "#{url}", follow_redirects: true }],
              inference: true,
            },
          ]
        end
      end
    end
  end
end
