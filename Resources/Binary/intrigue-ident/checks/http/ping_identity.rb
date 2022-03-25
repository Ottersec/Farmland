module Intrigue
module Ident
module Check
class PingIdentiy < Intrigue::Ident::Check::Base

  def generate_checks(url)
    [
      {
        type: "fingerprint",
        category: "service",
        tags: ["Management", "Cloud", "Security", "PaaS"],
        vendor: "PingIdentity",
        product:"PingFederate",
        references: ["https://ping.force.com/Support/PingFederate/Administration/Single-sign-on-no-target796070NEW"],
        description:"redirect (may be interesting)",
        version: nil,
        match_logic: :all,
        matches: [
          {
            match_type: :content_headers,
            match_content:  /^location:.*startSSO.ping/,
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
