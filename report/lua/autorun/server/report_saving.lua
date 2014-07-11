local function SaveReports()
	print("[REPORTS] Preparing to save reports!");

	local reports = util.TableToJSON(reports);

	if (!file.IsDir("reports", "DATA")) then file.CreateDir("reports"); end
	file.Write("reports/reports.txt", reports); //overwrite the other report file.

	if (file.Exists("reports/reports.txt", "DATA")) then
		print("[REPORTS] Reports saved!");
	end
end

timer.Create("SV_ReportSaving", report.SaveInterval, 0, function()
	if (#reports == 0) then return; end //don't override a report file with no reports.

	SaveReports();
end)

hook.Add("Initialize", "LoadReports", function()
	if (file.Exists("reports/reports.txt", "DATA")) then 
		local rep = file.Read("reports/reports.txt", "DATA");
		reports = util.JSONToTable(rep);
	end
end)