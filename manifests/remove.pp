# @summary Removes (uninstalls) a given list of packages.
#
# Can be called from a hiera config YAML.
#
# @example
#   classes:
#       - 'mspackages::remove'
#
#   mspackages::remove::packages:
#       - 'msodbcsql17'
#       - 'mssql-tools'
class mspackages::remove (
    Variant[Array[String, 0]] $packages = [],
) {
    Array($packages)  # Validates $packages as an array

    $packages.each |String $package| {
        $package_hash = {
            $package => {
                name   => $package,
                ensure => absent,
            }
        }

        Hash($package_hash)  # Validates $package_hash as a hash

        create_resources('mspackages::package', $package_hash)
    }
}
