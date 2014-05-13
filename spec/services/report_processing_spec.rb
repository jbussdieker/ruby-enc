require 'spec_helper.rb'
require 'tempfile'

describe ReportProcessing do
  let(:report) { FactoryGirl.create(:report) }
  let(:report_processing) { ReportProcessing.new(report) }

  before(:each) do
    @dummy = report_processing
  end

  describe 'delete_file' do
    subject { @dummy.delete_file }
    before { @dummy.stub(:filename).and_return("file") }

    context 'when filename exists' do
      before { File.stub(:exists?).and_return(true) }

      it 'deletes the file' do
        File.should_receive(:delete)
        subject
      end
    end

    context 'when filename does not exist' do
      before { File.stub(:exists?).and_return(false) }

      it 'does not delete the file' do
        File.should_not_receive(:delete)
        subject
      end
    end
  end

  describe 'write' do
    let(:data) { "foobar" }
    let(:file) { double.as_null_object }
    subject { @dummy.write(data) }
    before { @dummy.stub(:filename).and_return("file") }

    it 'writes to the file' do
      File.should_receive(:open).and_yield(file)
      file.should_receive(:write).with(data)
      subject
    end
  end

  describe 'raw_report' do
    subject { @dummy.raw_report }
    before { @dummy.stub(:filename).and_return("file") }

    it 'should read the file' do
      File.should_receive(:read).with("file")
      subject
    end
  end

  describe 'spool_path' do
    it 'Uses the config setting if present' do
      ENC_CONFIG.should_receive(:[]).with(:spool_path).and_return("/path/to")
      @dummy.spool_path.should eql('/path/to')
    end

    it 'Falls back to the project directory' do
      ENC_CONFIG.should_receive(:[]).with(:spool_path).and_return(nil)
      @dummy.spool_path.should eql(File.join(Rails.root, 'spool'))
    end
  end

  describe 'filename' do
    before(:each) do
      @id = Faker::Number.number(3)
      @dummy.stub(:id).and_return(@id)
    end

    it 'Uses spool_path' do
      @dummy.should_receive(:spool_path).and_return("/")
      @dummy.filename
    end

    it 'Generates the proper path' do
      @dummy.should_receive(:spool_path).and_return("/")
      @dummy.filename.should eql("/report-#{report.id}.yaml")
    end
  end

  describe 'parse' do
    before :each do
      file = Tempfile.new('parsetest')
      file.write(File.read("spec/fixtures/reports/puppet-3.3.2/changed.yaml"))
      file.rewind
      @dummy.stub(:filename).and_return(file.path)
    end

    it "creates 5 report logs" do
      expect {
        @dummy.parse
      }.to change(ReportLog, :count).by(5)
    end

    it "creates 16 metrics" do
      expect {
        @dummy.parse
      }.to change(Metric, :count).by(16)
    end

    it "creates 1 resource statuses" do
      expect {
        @dummy.parse
      }.to change(ResourceStatus, :count).by(1)
    end
  end

  describe 'compatability' do
    Dir[File.join("spec/fixtures/reports", "*")].each do |testpath|
      name = File.basename(testpath)
      context "#{name}" do
        [:changed, :pending, :failed, :unchanged].each do |type|
          context "#{type}" do
            before(:each) do
              report = File.read("spec/fixtures/reports/#{name}/#{type}.yaml")
              @dummy.stub(:raw_report).and_return(report)
            end

            it "logs" do
              # Capture test
              #File.open("spec/fixtures/reports/#{name}/#{type}.logs.yaml", 'w') do |f|
              #  f.write(@dummy.parse_logs.to_yaml)
              #end

              # Run test
              s = YAML.load(File.read("spec/fixtures/reports/#{name}/#{type}.logs.yaml"))
              @dummy.parse_logs.should eql(s)
            end

            it "metrics" do
              # Capture test
              #File.open("spec/fixtures/reports/#{name}/#{type}.metrics.yaml", 'w') do |f|
              #  f.write(@dummy.parse_metrics.to_yaml)
              #end

              # Run test
              s = YAML.load(File.read("spec/fixtures/reports/#{name}/#{type}.metrics.yaml"))
              @dummy.parse_metrics.should eql(s)
            end

            # TODO Figure out what's wrong with 2.7.23 resource status reporting
            unless name == "puppet-2.7.23" && type == :pending
              it "status" do
                @dummy.parse_status.should eql(type.to_s)
              end
            end
          end
        end
      end
    end
  end
end
