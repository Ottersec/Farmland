module Intrigue
module Ident
module Check
class Kerio < Intrigue::Ident::Check::Base

  def generate_checks(url)
    [
      {
        type: "fingerprint",
        category: "application",
        tags: ["COTS", "Appliance", "Administrative"],
        vendor: "Kerio",
        product:"Connect",
        description:"server header",
        version: nil,
        match_logic: :all,
        matches: [
          {
            match_type: :content_headers,
            match_content:  /^server: Kerio Connect.*/i,
          }
        ],
        references: [
          "http://www.kerio.com/support/kerio-connect/release-history",
          "https://www.cvedetails.com/cve/CVE-2017-7440/"
        ],
        dynamic_version: lambda { |x|
          _first_header_capture(x,/^server: Kerio Connect (.*)/i)
        },
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: true
      }
    ]
  end

end
end
end
end
