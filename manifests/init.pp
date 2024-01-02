# @summary Installs a given package name.
#
# Installs a given package name with the 'ACCEPT_EULA=Y' environment variable
# set, as required for Microsoft packages.
#
# @example
#   mspackages { 'msodbcsql17':
#       ensure =>  present,
#   }
define mspackages (
    Variant[String, String[1]] $ensure = present,
) {
    String($name)  # Validates $name as a string
    Pattern[/^(present|installed|absent)$/]($ensure)  # Validates $ensure against the pattern

    $package_hash = {
        $name => {
            name   => $name,
            ensure => $ensure,
        }
    }

    Hash($package_hash)  # Validates $package_hash as a hash

    create_resources('mspackages::package', $package_hash)
}
