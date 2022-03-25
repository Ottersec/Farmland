module Intrigue
module Ident
module Check
class XmbCMS < Intrigue::Ident::Check::Base

  def generate_checks(url)
    [
      {
        type: "fingerprint",
        category: "application",
        tags: ["CMS"],
        vendor: "XMB",
        product: "XMB",
        references: ["https://forums.xmbforum2.com/"],
        version: nil,
        match_logic: :all,
        matches: [
          {
            match_type: :content_body,
            match_content: /Powered by XMB (\d.*.\d)/i,
          }
        ],
        dynamic_version: lambda { |x| _first_body_capture(x, /Powered by XMB (\d.*.\d)/i)},
        description: "Header match",
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
