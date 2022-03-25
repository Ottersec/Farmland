module Intrigue
module Ident
module Check
class Xtec < Intrigue::Ident::Check::Base

  def generate_checks(url)
    [
      {
        type: "fingerprint",
        category: "application",
        tags: ["IAM"],
        vendor: "Xtec",
        product:"AuthentXware",
        references: ["http://www.xtec.com/products/logical-access-control/authentxware.html"],
        description:"header",
        version: nil,
        match_logic: :all,
        matches: [
          {
            match_type: :content_headers,
            match_content:  /^x-tec-api-version:.*/,
          }
        ],
        dynamic_version: lambda {|x| 
          _first_header_capture(x,/^x-tec-api-version: v(.*)/)},
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: true  # No cpes on 20190319
      }
    ]
  end

end
end
end
end
