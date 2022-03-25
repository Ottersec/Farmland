module Intrigue
module Ident
module Check
class SeamlessCMS < Intrigue::Ident::Check::Base

  def generate_checks(url)
    [
      {
        type: "fingerprint",
        category: "service",
        tags: ["CMS"],
        vendor: "SeamlessCMS",
        product: "SeamlessCMS",
        references: ["https://www.seamlesscms.com/"],
        version: nil,
        match_logic: :all,
        matches: [
          {
            match_type: :content_body,
            match_content: /Published by Seamless.CMS.WebUI, ([\d\.]+)/i,
          }
        ], 
        dynamic_version: lambda { |x| _first_body_capture(x, /Published by Seamless.CMS.WebUI, ([\d\.]+)/i)},
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
