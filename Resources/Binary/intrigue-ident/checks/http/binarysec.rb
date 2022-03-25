module Intrigue
module Ident
module Check
class Binarysec < Intrigue::Ident::Check::Base

  def generate_checks(url)
    [
      {
        type: "fingerprint",
        category: "application",
        tags: ["WAF"],
        website: "",
        references: [
          "https://github.com/EnableSecurity/wafw00f"
        ],
        vendor: "BinarySEC",
        product:"Web Application Firewall",
        description:"cookie",
        version: nil,
        match_logic: :all,
        matches: [
          {
            match_type: :content_headers,
            match_content:  /server: BinarySec/i,
          }
        ],
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: false
      }, 
      {
        type: "fingerprint",
        category: "application",
        tags: ["WAF"],
        website: "",
        references: [
          "https://github.com/EnableSecurity/wafw00f"
        ],
        vendor: "BinarySEC",
        product:"Web Application Firewall",
        description:"cookie",
        version: nil,
        match_logic: :all,
        matches: [
          {
            match_type: :content_headers,
            match_content:  /x-binarysec/i,
          }
        ],
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: false
      }
    ]
  end
end
end
end
end
