module Intrigue
module Ident
module Check
class OpenSolutionCMS < Intrigue::Ident::Check::Base

  def generate_checks(url)
    [
      {
        type: "fingerprint",
        category: "application",
        tags: ["CMS"],
        vendor: "OpenSolution",
        product: "Quick.Cart",
        references: ["https://opensolution.org/"],
        version: nil,
        match_logic: :all,
        matches: [
          {
            match_type: :content_body,
            match_content: /Quick.Cart(.*?)v([\d\.]+)/i,
          }
        ],
        dynamic_version: lambda { |x| _first_body_capture(x, /ext v([\d\.]+)/i)},
        description: "header match",
        hide: false,
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: true
      },
      {
        type: "fingerprint",
        category: "application",
        tags: ["CMS"],
        vendor: "OpenSolution",
        product: "Quick.Cms",
        references: ["https://opensolution.org/"],
        version: nil,
        match_logic: :all,
        matches: [
          {
            match_type: :content_body,
            match_content: /quick.cms v([\d\.]+)/i,
          }
        ],
        dynamic_version: lambda { |x| _first_body_capture(x, /quick.cms v([\d\.]+)/i)},
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
