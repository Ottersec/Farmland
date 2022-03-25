module Intrigue
module Ident
module Check
class Enservio < Intrigue::Ident::Check::Base

  def generate_checks(url)
    [
      {
        type: "fingerprint",
        category: "service",
        tags: ["CMS"],
        website: "https://www.enservio.com/about-us/about-enservio",
        vendor: "Enservio",
        product: "Enservio",
        references: [],
        version: nil,
        match_logic: :all,
        matches: [
          {
            match_type: :content_cookies,
            match_content: /_enservio_session=/i,
          }
        ],
        description: "cookie match",
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
