module Intrigue
  module Ident
  module Check
  class OneTwoThreeReg < Intrigue::Ident::Check::Base
  
    def generate_checks(url)
      [
        {
          type: "fingerprint",
          category: "service",
          tags: ["Parked"],
          vendor: "123Reg",
          product: "123Reg",
          website: "https://www.123-reg.co.uk/",
          references: [],
          match_logic: :all,
          matches: [
            {
              match_type: :content_title,
              match_content: /Want your own website\? \| 123 Reg/i
            }  
          ],
          description: "Want your own website\? \| 123 Reg",
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
  
