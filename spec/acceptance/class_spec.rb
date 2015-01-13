require 'spec_helper_acceptance'

describe 'perlbrew::perl::ssl class' do
  context 'default parameters' do
    manifest = <<-EOS
      include perlbrew
      perlbrew::perl::ssl { 'default_perl' : }
    EOS

    it 'should apply without failure' do
      apply_manifest_on hosts, manifest, :catch_failures => true
    end

    it 'should re-apply without changes' do
      apply_manifest_on hosts, manifest, :catch_changes => true
    end
  end
end
