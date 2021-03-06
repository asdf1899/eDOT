class ReportsController < ApplicationController
  before_action :set_patient
  before_action :set_report, only: [:show, :edit, :update, :destroy]
  before_action :set_users, only: [:new, :edit, :update, :create]
  before_action :authenticate_user!

  # GET /reports
  # GET /reports.json
  # def index
  #   @reports = Report.all
  # end

  def index
    @reports = @patient.reports
    respond_to do |format|
      format.html
      format.csv
     end
  end


  # GET /reports/1
  # GET /reports/1.json
  def show
  end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(report_params)

    respond_to do |format|
      if @report.save
        @report.position=(Position.create!(patient_id: @report.patient_id,
        latitude: Geocoder.coordinates(@report.address)[0] ,
        longitude: Geocoder.coordinates(@report.address)[1]))
        format.html { redirect_to patient_report_url(@report.patient, @report), notice: 'Report was successfully created.' }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { render :new }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    respond_to do |format|
      if @report.update(report_params)
        @report.position.update(
        latitude: Geocoder.coordinates(@report.address)[0] ,
        longitude: Geocoder.coordinates(@report.address)[1])
        format.html { redirect_to patient_report_url(@report.patient, @report), notice: 'Report was successfully updated.' }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.position.destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to patient_reports_url(@patient), notice: 'Report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      pp = params.require(:report).permit(:patient_id, :user_id, :date,:address, :health_status)
      pp[:patient_id] = @patient.id
      return pp
    end

    def set_patient
      @patient = Patient.find(params[:patient_id])
    end

    def set_users
      @users = User.all
    end
end
