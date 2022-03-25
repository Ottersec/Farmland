module Intrigue
  module Ident
  module Check
  class Ucoz < Intrigue::Ident::Check::Base
  
    def generate_checks(url)
      [
        {
          type: "fingerprint",
          category: "service",
          tags: ["CMS", "Hosting"],
          vendor: "uCoz",
          product: "uCoz",
          website: "https://www.ucoz.com/",
          references: [],
          version: nil,
          match_logic: :all,
          matches: [
            {
              match_type: :content_body,
              match_content: /title\=\"Hosted by uCoz\"/i,
            }
          ],
          description: "title\=\"Hosted by uCoz\"",
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
  
