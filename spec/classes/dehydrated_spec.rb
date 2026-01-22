# frozen_string_literal: true

require 'spec_helper'

describe 'dehydrated' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      let(:acme_challenge_dir) do
        if facts[:os]['family'] == 'FreeBSD'
          '/usr/local/etc/dehydrated/.acme-challenges'
        else
          '/home/dehydrated/.acme-challenges'
        end
      end

      let(:config_path) do
        if facts[:os]['family'] == 'FreeBSD'
          '/usr/local/etc/dehydrated/config'
        else
          '/home/dehydrated/config'
        end
      end

      context 'with default parameters' do
        let(:params) do
          {
            'contact_email' => 'bob@example.com'
          }
        end

        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_package('curl').with(ensure: 'installed') } if facts[:os]['family'] == 'Debian'

        it { is_expected.to contain_file(config_path).with_content(<<~CONTENT) }
          # Managed by Puppet

          # Which user should dehydrated run as? This will be implicitly enforced when running as root
          #DEHYDRATED_USER=

          # Which group should dehydrated run as? This will be implicitly enforced when running as root
          #DEHYDRATED_GROUP=

          # Resolve names to addresses of IP version only. (curl)
          # supported values: 4, 6
          # default: <unset>
          #IP_VERSION=

          # URL to certificate authority or internal preset
          # Presets: letsencrypt, letsencrypt-test, zerossl, buypass, buypass-test, google, google-test
          # default: letsencrypt
          #CA="letsencrypt"

          # Path to old certificate authority
          # Set this value to your old CA value when upgrading from ACMEv1 to ACMEv2 under a different endpoint.
          # If dehydrated detects an account-key for the old CA it will automatically reuse that key
          # instead of registering a new one.
          # default: https://acme-v01.api.letsencrypt.org/directory
          #OLDCA="https://acme-v01.api.letsencrypt.org/directory"

          # Which challenge should be used? Currently http-01, dns-01 and tls-alpn-01 are supported
          #CHALLENGETYPE="http-01"

          # Path to a directory containing additional config files, allowing to override
          # the defaults found in the main configuration file. Additional config files
          # in this directory needs to be named with a '.sh' ending.
          # default: <unset>
          #CONFIG_D=

          # Directory for per-domain configuration files.
          # If not set, per-domain configurations are sourced from each certificates output directory.
          # default: <unset>
          #DOMAINS_D=

          # Base directory for account key, generated certificates and list of domains (default: $SCRIPTDIR -- uses config directory if undefined)
          #BASEDIR=$SCRIPTDIR

          # File containing the list of domains to request certificates for (default: $BASEDIR/domains.txt)
          #DOMAINS_TXT="${BASEDIR}/domains.txt"

          # Output directory for generated certificates
          #CERTDIR="${BASEDIR}/certs"

          # Output directory for alpn verification certificates
          #ALPNCERTDIR="${BASEDIR}/alpn-certs"

          # Directory for account keys and registration information
          #ACCOUNTDIR="${BASEDIR}/accounts"

          # Output directory for challenge-tokens to be served by webserver or deployed in HOOK (default: /var/www/dehydrated)
          #WELLKNOWN="/var/www/dehydrated"
          WELLKNOWN='#{acme_challenge_dir}'

          # Default keysize for private keys (default: 4096)
          #KEYSIZE="4096"

          # Path to openssl config file (default: <unset> - tries to figure out system default)
          #OPENSSL_CNF=

          # Path to OpenSSL binary (default: "openssl")
          #OPENSSL="openssl"

          # Extra options passed to the curl binary (default: <unset>)
          #CURL_OPTS=

          # Program or function called in certain situations
          #
          # After generating the challenge-response, or after failed challenge (in this case altname is empty)
          # Given arguments: clean_challenge|deploy_challenge altname token-filename token-content
          #
          # After successfully signing certificate
          # Given arguments: deploy_cert domain path/to/privkey.pem path/to/cert.pem path/to/fullchain.pem
          #
          # BASEDIR and WELLKNOWN variables are exported and can be used in an external program
          # default: <unset>
          #HOOK=

          # Chain clean_challenge|deploy_challenge arguments together into one hook call per certificate (default: no)
          #HOOK_CHAIN="no"

          # Minimum days before expiration to automatically renew certificate (default: 32)
          #RENEW_DAYS="32"

          # Regenerate private keys instead of just signing new certificates on renewal (default: yes)
          #PRIVATE_KEY_RENEW="yes"

          # Create an extra private key for rollover (default: no)
          #PRIVATE_KEY_ROLLOVER="no"

          # Which public key algorithm should be used? Supported: rsa, prime256v1 and secp384r1
          #KEY_ALGO=secp384r1

          # E-mail to use during the registration (default: <unset>)
          #CONTACT_EMAIL=
          CONTACT_EMAIL='bob@example.com'

          # Lockfile location, to prevent concurrent access (default: $BASEDIR/lock)
          #LOCKFILE="${BASEDIR}/lock"

          # Option to add CSR-flag indicating OCSP stapling to be mandatory (default: no)
          #OCSP_MUST_STAPLE="no"

          # Fetch OCSP responses (default: no)
          #OCSP_FETCH="no"

          # OCSP refresh interval (default: 5 days)
          #OCSP_DAYS=5

          # Issuer chain cache directory (default: $BASEDIR/chains)
          #CHAINCACHE="${BASEDIR}/chains"

          # Automatic cleanup (default: no)
          #AUTO_CLEANUP="no"

          # Delete files during automatic cleanup instead of moving to archive (default: no)
          #AUTO_CLEANUP_DELETE="no"

          # ACME API version (default: auto)
          #API=auto

          # Preferred issuer chain (default: <unset> -> uses default chain)
          #PREFERRED_CHAIN=

          # Request certificate with specific profile (default: <unset>)
          #ACME_PROFILE=

          # Amount of seconds to wait for processing of order until erroring out (default: 0 => no timeout)
          #ORDER_TIMEOUT=0

          # Skip over errors during certificate orders and updating of OCSP stapling information (default: no)
          #KEEP_GOING=no
        CONTENT
      end

      context 'with all parameters set' do
        let(:params) do
          {
            'dehydrated_user' => 'acme',
            'dehydrated_group' => 'acme',
            'ip_version' => 6,
            'ca' => 'letsencrypt',
            'oldca' => 'https://acme-v01.api.letsencrypt.org/directory',
            'challengetype' => 'http-01',
            'config_d' => '/etc/dehydrated/config.d',
            'domains_d' => '/etc/dehydrated/domains.d',
            'basedir' => '/etc/dehydrated',
            'domains_txt' => '/etc/dehydrated/domains.txt',
            'certdir' => '/etc/dehydrated/certs',
            'alpncertdir' => '/etc/dehydrated/alpn-certs',
            'accountdir' => '/etc/dehydrated/accounts',
            'wellknown' => '/var/www/dehydrated',
            'keysize' => 4096,
            'openssl_cnf' => '/etc/ssl/openssl.cnf',
            'openssl' => 'openssl',
            'curl_opts' => '--verbose',
            'hook' => '/usr/local/bin/dehydrated-hook',
            'hook_chain' => false,
            'renew_days' => 32,
            'private_key_renew' => true,
            'private_key_rollover' => false,
            'key_algo' => 'secp384r1',
            'contact_email' => 'bob@example.com',
            'lockfile' => '/etc/dehydrated/lock',
            'ocsp_must_staple' => false,
            'ocsp_fetch' => false,
            'ocsp_days' => 5,
            'chaincache' => '/etc/dehydrated/chains',
            'auto_cleanup' => false,
            'auto_cleanup_delete' => false,
            'api' => 'auto',
            'preferred_chain' => 'default',
            'acme_profile' => 'shortlived',
            'order_timeout' => 0,
            'keep_going' => false
          }
        end

        it { is_expected.to contain_file(config_path).with_content(<<~CONTENT) }
          # Managed by Puppet

          # Which user should dehydrated run as? This will be implicitly enforced when running as root
          #DEHYDRATED_USER=
          DEHYDRATED_USER='acme'

          # Which group should dehydrated run as? This will be implicitly enforced when running as root
          #DEHYDRATED_GROUP=
          DEHYDRATED_GROUP='acme'

          # Resolve names to addresses of IP version only. (curl)
          # supported values: 4, 6
          # default: <unset>
          #IP_VERSION=
          IP_VERSION=6

          # URL to certificate authority or internal preset
          # Presets: letsencrypt, letsencrypt-test, zerossl, buypass, buypass-test, google, google-test
          # default: letsencrypt
          #CA="letsencrypt"
          CA='letsencrypt'

          # Path to old certificate authority
          # Set this value to your old CA value when upgrading from ACMEv1 to ACMEv2 under a different endpoint.
          # If dehydrated detects an account-key for the old CA it will automatically reuse that key
          # instead of registering a new one.
          # default: https://acme-v01.api.letsencrypt.org/directory
          #OLDCA="https://acme-v01.api.letsencrypt.org/directory"
          OLDCA='https://acme-v01.api.letsencrypt.org/directory'

          # Which challenge should be used? Currently http-01, dns-01 and tls-alpn-01 are supported
          #CHALLENGETYPE="http-01"
          CHALLENGETYPE='http-01'

          # Path to a directory containing additional config files, allowing to override
          # the defaults found in the main configuration file. Additional config files
          # in this directory needs to be named with a '.sh' ending.
          # default: <unset>
          #CONFIG_D=
          CONFIG_D='/etc/dehydrated/config.d'

          # Directory for per-domain configuration files.
          # If not set, per-domain configurations are sourced from each certificates output directory.
          # default: <unset>
          #DOMAINS_D=
          DOMAINS_D='/etc/dehydrated/domains.d'

          # Base directory for account key, generated certificates and list of domains (default: $SCRIPTDIR -- uses config directory if undefined)
          #BASEDIR=$SCRIPTDIR
          BASEDIR='/etc/dehydrated'

          # File containing the list of domains to request certificates for (default: $BASEDIR/domains.txt)
          #DOMAINS_TXT="${BASEDIR}/domains.txt"
          DOMAINS_TXT='/etc/dehydrated/domains.txt'

          # Output directory for generated certificates
          #CERTDIR="${BASEDIR}/certs"
          CERTDIR='/etc/dehydrated/certs'

          # Output directory for alpn verification certificates
          #ALPNCERTDIR="${BASEDIR}/alpn-certs"
          ALPNCERTDIR='/etc/dehydrated/alpn-certs'

          # Directory for account keys and registration information
          #ACCOUNTDIR="${BASEDIR}/accounts"
          ACCOUNTDIR='/etc/dehydrated/accounts'

          # Output directory for challenge-tokens to be served by webserver or deployed in HOOK (default: /var/www/dehydrated)
          #WELLKNOWN="/var/www/dehydrated"
          WELLKNOWN='/var/www/dehydrated'

          # Default keysize for private keys (default: 4096)
          #KEYSIZE="4096"
          KEYSIZE=4096

          # Path to openssl config file (default: <unset> - tries to figure out system default)
          #OPENSSL_CNF=
          OPENSSL_CNF='/etc/ssl/openssl.cnf'

          # Path to OpenSSL binary (default: "openssl")
          #OPENSSL="openssl"
          OPENSSL='openssl'

          # Extra options passed to the curl binary (default: <unset>)
          #CURL_OPTS=
          CURL_OPTS='--verbose'

          # Program or function called in certain situations
          #
          # After generating the challenge-response, or after failed challenge (in this case altname is empty)
          # Given arguments: clean_challenge|deploy_challenge altname token-filename token-content
          #
          # After successfully signing certificate
          # Given arguments: deploy_cert domain path/to/privkey.pem path/to/cert.pem path/to/fullchain.pem
          #
          # BASEDIR and WELLKNOWN variables are exported and can be used in an external program
          # default: <unset>
          #HOOK=
          HOOK='/usr/local/bin/dehydrated-hook'

          # Chain clean_challenge|deploy_challenge arguments together into one hook call per certificate (default: no)
          #HOOK_CHAIN="no"
          HOOK_CHAIN='no'

          # Minimum days before expiration to automatically renew certificate (default: 32)
          #RENEW_DAYS="32"
          RENEW_DAYS=32

          # Regenerate private keys instead of just signing new certificates on renewal (default: yes)
          #PRIVATE_KEY_RENEW="yes"
          PRIVATE_KEY_RENEW='yes'

          # Create an extra private key for rollover (default: no)
          #PRIVATE_KEY_ROLLOVER="no"
          PRIVATE_KEY_ROLLOVER='no'

          # Which public key algorithm should be used? Supported: rsa, prime256v1 and secp384r1
          #KEY_ALGO=secp384r1
          KEY_ALGO='secp384r1'

          # E-mail to use during the registration (default: <unset>)
          #CONTACT_EMAIL=
          CONTACT_EMAIL='bob@example.com'

          # Lockfile location, to prevent concurrent access (default: $BASEDIR/lock)
          #LOCKFILE="${BASEDIR}/lock"
          LOCKFILE='/etc/dehydrated/lock'

          # Option to add CSR-flag indicating OCSP stapling to be mandatory (default: no)
          #OCSP_MUST_STAPLE="no"
          OCSP_MUST_STAPLE='no'

          # Fetch OCSP responses (default: no)
          #OCSP_FETCH="no"
          OCSP_FETCH='no'

          # OCSP refresh interval (default: 5 days)
          #OCSP_DAYS=5
          OCSP_DAYS=5

          # Issuer chain cache directory (default: $BASEDIR/chains)
          #CHAINCACHE="${BASEDIR}/chains"
          CHAINCACHE='/etc/dehydrated/chains'

          # Automatic cleanup (default: no)
          #AUTO_CLEANUP="no"
          AUTO_CLEANUP='no'

          # Delete files during automatic cleanup instead of moving to archive (default: no)
          #AUTO_CLEANUP_DELETE="no"
          AUTO_CLEANUP_DELETE='no'

          # ACME API version (default: auto)
          #API=auto
          API='auto'

          # Preferred issuer chain (default: <unset> -> uses default chain)
          #PREFERRED_CHAIN=
          PREFERRED_CHAIN='default'

          # Request certificate with specific profile (default: <unset>)
          #ACME_PROFILE=
          ACME_PROFILE='shortlived'

          # Amount of seconds to wait for processing of order until erroring out (default: 0 => no timeout)
          #ORDER_TIMEOUT=0
          ORDER_TIMEOUT=0

          # Skip over errors during certificate orders and updating of OCSP stapling information (default: no)
          #KEEP_GOING=no
          KEEP_GOING='no'
        CONTENT
      end
    end
  end
end
