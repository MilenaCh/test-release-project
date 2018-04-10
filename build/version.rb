require 'yaml'

version_data = YAML.load(File.read('VERSION'))

now = Time.now

VERSION_YEAR = version_data['year'].to_i

month = [(now.month + (now.year - VERSION_YEAR) * 12), 0].max

VERSION_DATE = month * 100 + now.day

VERSION_Q = version_data['release'].to_i
VERSION_SERVICE_PACK = version_data['servicePack']
SERVICE_PACK_NUMBER = version_data['servicePackNumber']

VERSION = ENV['VERSION'] || "#{VERSION_YEAR}.#{VERSION_Q}.#{VERSION_DATE}"

CURRENT_COMMIT = `git rev-parse HEAD`.strip
BETA = !!ENV['BETA']

def prefix_bundle_name(bundle)
    if bundle =~ /mvc|php|jsp|asp/
        prefix = 'telerik.ui.for.'
    else
        if bundle =~ /jquery/
        prefix = 'kendoui.for.'
        else
            if bundle == 'core'
                prefix = 'kendoui.'
            else
                prefix = 'telerik.kendoui.'
            end
        end
    end

    prefix + bundle
end

def versioned_bundle_name(bundle)
    prefix_bundle_name(bundle).sub(/\.[^\.]+$/, ".#{VERSION}\\0")
end
def versioned_bundle_beta_name(bundle)
    prefix_bundle_name(bundle).sub(/\.[^\.]+$/, ".#{VERSION}.beta\\0")
end

def latest_bundle_name(bundle)
    prefix_bundle_name(bundle).sub(/\.[^\.]+$/, ".latest\\0")
end
