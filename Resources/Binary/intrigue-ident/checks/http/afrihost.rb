module Intrigue
  module Ident
    module Check
      class AfriHost < Intrigue::Ident::Check::Base
        def generate_checks(url)
          [
            {
              type: "fingerprint",
              category: "service",
              tags: ["Parked"],
              vendor: "AfriHost",
              product: "AfriHost",
              website: "https://www.afrihost.com/",
              version: nil,
              match_logic: :all,
              matches: [
                {
                  match_type: :content_title,
                  match_content: /^Domain Parked$/i,
                }
              ],
              description: "Domain Parked",
              hide: false,
              paths: [{ path: "#{url}", follow_redirects: true }],
              inference: false,
            },
          ]
        end
      end
    end
  end
end
