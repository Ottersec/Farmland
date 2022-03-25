module Intrigue
module Ident
module Check
class XCms < Intrigue::Ident::Check::Base

  def generate_checks(url)
    [
      {
        type: "fingerprint",
        category: "application",
        tags: ["CMS"],
        vendor: "X-CMS",
        product: "X-CMS",
        references: ["https://xcmsonline.scripps.edu//"],
        version: nil,
        match_logic: :all,
        matches: [
          {
            match_type: :content_body,
            match_content: /X-CMS-Version: ([\d\.]+)/i,
          }
        ],
        dynamic_version: lambda { |x| _first_body_capture(x, /X-CMS-Version: ([\d\.]+)/i) },
        description: "header match",
        hide: false,
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: true
      }
    ]
  end
  
end
end
end
end
