module Intrigue
  module Ident
    module FtpCheck
      class Generic < Intrigue::Ident::FtpCheck::Base
        # 220 1.1.1.1 FTP server ready
        def generate_checks
          [
            {
              type: 'fingerprint',
              category: 'application',
              tags: ['FTP Server'],
              vendor: 'Generic',
              product: 'FTP',
              references: [],
              version: nil,
              match_type: :content_banner,
              match_content: /(FTP|^220)/i,
              description: 'banner',
              hide: false,
              inference: true
            }
          ]
        end
      end
    end
  end
end
