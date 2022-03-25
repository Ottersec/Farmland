  module Intrigue
  module Ident
  module Check
  class Nexicom < Intrigue::Ident::Check::Base

    def generate_checks(url)
      [
        {
          type: "fingerprint",
          category: "service",
          tags: ["Parked"],
          vendor: "Nexicom",
          product: "Nexicom",
          website: "https://nexicom.net/",
          version: nil,
          match_logic: :all,
          matches: [
            {
              match_type: :content_body,
              match_content: /\<STRONG\>What\ is\ Domain\ Parking\?\<\/STRONG\>/i,
            }
          ],
          description: "<STRONG>What is Domain Parking?</STRONG>",
          hide: false,
          paths: [ { path: "#{url}", follow_redirects: true } ],
          inference: false
        },
        {
          type: "fingerprint",
          category: "service",
          tags: ["Parked"],
          vendor: "Nexicom",
          product: "Nexicom",
          website: "https://nexicom.net/",
          version: nil,
          match_logic: :all,
          matches: [
            {
              match_type: :content_title,
              match_content: /Park\ your\ Domain\ \@\ Nexicom/i,
            }
          ],
          description: "Park\ your\ Domain\ \@\ Nexicom",
          hide: false,
          paths: [ { path: "#{url}", follow_redirects: true } ],
          inference: false
        }
      ]
    end

  end
  end
  end
  end
