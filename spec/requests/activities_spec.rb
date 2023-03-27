require 'rails_helper'

RSpec.describe "/activities", type: :request do
    let(:day)       { create(:day) }
    let(:activity)  { create(:activity, day: day) }

    describe "POST /activities" do
        it "creates a new activity" do
            expect{
                post activities_path, params: {}
            }.to change{Activity.count}.from(0).to(1)
        end

        context "with existing day" do
            before { day }

            it "doesn't create a new day" do
                expect{
                    post activities_path, params: {}
                }.not_to change{Day.count}
            end
        end

        context "without existing day" do
            it "does create a new day" do
                expect{
                    post activities_path, params: {}
                }.to change{Day.count}.from(0).to(1)
            end
        end
    end

end