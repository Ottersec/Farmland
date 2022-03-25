module Intrigue
  module Ident
    module Check
      class Google < Intrigue::Ident::Check::Base
        def generate_checks(url)
          [
            {
              type: 'fingerprint',
              category: 'service',
              tags: %w[Marketing JavaScript],
              vendor: 'Google',
              product: 'Analytics',
              website: 'https://analytics.google.com/',
              description: 'Google Analytics - Body Match',
              version: nil,
              match_logic: :any,
              matches: [
                {
                  match_type: :content_body,
                  match_content: /getTracker\(["|']UA-/im,
                },
                {
                  match_type: :content_body,
                  match_content: %r{www.google-analytics.com/analytics.js','ga'}im,
                }
              ],
              paths: [{ path: url.to_s, follow_redirects: true }],
              inference: false
            },
            {
              type: 'fingerprint',
              category: 'service',
              tags: %w[Frontend JavaScript],
              vendor: 'Google',
              product: 'AngularJS',
              website: 'https://angularjs.org/',
              description: 'Google AngularJS - Body Match',
              version: nil,
              match_logic: :any,
              matches: [
                {
                  match_type: :content_body,
                  match_content: /ng-app=/im,
                },
                {
                  match_type: :content_body,
                  match_content: /\*ngIf=/im,
                },
                {
                  match_type: :content_body,
                  match_content: /ng-controller=/im,
                }
              ],
              paths: [{ path: url.to_s, follow_redirects: true }],
              inference: false
            },
            {
              type: 'fingerprint',
              category: 'service',
              tags: ['Development'],
              vendor: 'Google',
              product: 'Firebase',
              website: 'https://firebase.google.com/',
              references: [],
              version: nil,
              match_logic: :all,
              matches: [
                {
                  match_type: :content_body,
                  match_content: /This is a custom domain, but we haven't finished setting it up yet./i,
                }
              ],
              description: 'firebase error',
              hide: false,
              paths: [{ path: url.to_s, follow_redirects: true }],
              inference: false
            },
            {
              type: 'fingerprint',
              category: 'service',
              tags: %w[IaaS SaaS],
              vendor: 'Google',
              product: 'Google',
              references: ['https://cloud.google.com/storage/docs/xml-api/reference-headers'],
              description: 'Google - Headers Match',
              version: nil,
              match_logic: :any,
              matches: [
                {
                  match_type: :content_headers,
                  match_content: /^x-goog-stored-content-encoding:.*$/i,
                },
                {
                  match_type: :content_headers,
                  match_content: /^x-goog-generation:.*$/i,
                },
                {
                  match_type: :content_headers,
                  match_content: /^server: ghs$/i,
                },
                {
                  match_type: :content_headers,
                  match_content: /^server: GSE$/i,
                },
                {
                  match_type: :content_headers,
                  match_content: /^server: gws$/i,
                }
              ],
              paths: [{ path: url.to_s, follow_redirects: true }],
              inference: false
            },
            {
              type: 'fingerprint',
              category: 'service',
              tags: ['IaaS', 'SaaS', 'Website'],
              vendor: 'Google',
              product: 'Google',
              website: 'https://www.google.com/',
              description: 'Google Missing Page',
              version: nil,
              match_logic: :all,
              matches: [
                {
                  match_type: :content_body,
                  match_content: %r{The requested URL <code>/</code> was not found on this server\.},
                }
              ],
              hide: true,
              paths: [{ path: url.to_s, follow_redirects: true }],
              inference: false
            },
            {
              type: 'fingerprint',
              category: 'application',
              tags: %w[Embedded Appliance COTS],
              vendor: 'Google',
              product: 'Search Appliance',
              website: 'https://workspace.google.com/products/cloud-search/',
              description: 'server header reports google search appliance',
              version: nil,
              match_logic: :all,
              matches: [
                {
                  match_type: :content_headers,
                  match_content: /server: Google Search Appliance/i,
                }
              ],
              paths: [{ path: url.to_s, follow_redirects: true }],
              inference: false
            },
            {
              type: 'fingerprint',
              category: 'application',
              tags: %w[Marketing JavaScript],
              vendor: 'Google',
              product: 'Tag Manager',
              website: 'https://tagmanager.google.com/',
              description: 'js load string',
              version: nil,
              match_logic: :all,
              matches: [
                {
                  match_type: :content_body,
                  match_content: /<!-- End Google Tag Manager -->/im,
                }
              ],
              paths: [{ path: url.to_s, follow_redirects: true }],
              inference: false
            },
            {
              type: 'fingerprint',
              category: 'service',
              tags: ['Networking', 'Load Balancer'],
              vendor: 'Google',
              product: 'Google Cloud Load Balancer',
              website: 'https://cloud.google.com/load-balancing',
              description: 'cookie',
              version: nil,
              match_logic: :all,
              matches: [
                {
                  match_type: :content_cookies,
                  match_content: /GCLB=/i,
                }
              ],
              paths: [{ path: url.to_s, follow_redirects: true }],
              inference: false
            }
            # Currently match_content too loose, also no point in inference if we dont' have a versions
            # {
            #  type: "fingerprint",
            #  category: "application",
            #  tags: ["CMS"],
            #  vendor: "Google",
            #  product: "blogger",
            #  references: ["https://www.blogger.com/"],
            #  version: nil,
            #  match_type: :content_body,
            #  match_content: /blogger/i,
            #  dynamic_version: nil,
            #  description: "header match",
            #  hide: false,
            #  paths: [ { path: "#{url}", follow_redirects: true } ],
            #  inference: true
            # }
          ]
        end
      end
    end
  end
end
