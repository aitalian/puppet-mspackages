# @summary Installs given list of packages.
#
# Can be called from a hiera config YAML.
#
# @example
#   classes:
#       - 'mspackages::install'
#
#   mspackages::install::packages:
#       - 'msodbcsql17'
#       - 'mssql-tools'
class mspackages::install (
    Variant[Array, Array[String, 0]] $packages = [],
) {
    Array($packages)  # Validates $packages as an array

    $packages.each |String $package| {
        $package_hash = {
            $package => {
                name   => $package,
                ensure => present,
            }
        }

        validate_hash($package_hash)

        create_resources('mspackages::package', $package_hash)
    }
}
