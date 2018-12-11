package functions.bitBucket

import java.io.File
import java.io.FileInputStream
import java.io.FileOutputStream
import org.apache.poi.ss.usermodel.Sheet
import org.apache.poi.ss.usermodel.Workbook
import org.apache.poi.ss.usermodel.WorkbookFactory
import org.openqa.selenium.remote.RemoteWebDriver
import pages.BasePage
import pages.bitBucket.DashboardOverviewPage
import pages.bitBucket.DashboardRepoPage
import testBase.BaseTest

class Bitbucket_Func extends BasePage {

	new(RemoteWebDriver driver) {
		super(driver)

	}

	/**
	 * Copy and paste repo URLs into excel sheet
	 * @param excelPath Excel sheet path
	 * @param sheetNo The excel sheet number
	 * @param firstDriverID The first driver ID
	 * @param rowNo The total row number
	 * @param transactionReason The transaction reason
	 * @author shameer
	 */
	def void copyAndPasteRepoUrls(String excelPath, int sheetNo) {
		var DashboardOverviewPage dashOverviewPage = new DashboardOverviewPage(driver)
		var DashboardRepoPage repoPage = new DashboardRepoPage(driver)
		
		dashOverviewPage.txt_filterContainers.waitToBeDisplayed
		//dashOverviewPage.link_viewAllRepos.click
		Thread.sleep(1000)
		waitForPageLoadComplete(driver)
		
		for(var i=0;i<repoPage.link_allRepos.size;i++){
			
			var Workbook wb = WorkbookFactory.create(new FileInputStream(excelPath))
			var Sheet sheet = wb.getSheetAt(sheetNo)
			var row = sheet.createRow(i);
			
			waitForPageLoadComplete(driver)
			Thread.sleep(1000)
			repoPage.link_allRepos.get(i).click
			try{
			repoPage.btn_clone.waitToBeDisplayed
			repoPage.btn_clone.waitToBeClickable
			repoPage.btn_clone.click
			Thread.sleep(500)
			repoPage.txt_cloneRepoUrl.waitToBeDisplayed
			var repoURL=repoPage.txt_cloneRepoUrl.getAttribute("value")
			
			row.createCell(0).setCellValue(i);
			row.createCell(1).setCellValue(repoURL);
			var FileOutputStream out = new FileOutputStream(new File(excelPath))
			wb.write(out)
			out.close()
			
			repoPage.btn_closeRepo.waitToBeClickable
			repoPage.btn_closeRepo.click
			Thread.sleep(500)
			
			driver.navigate.back
			waitForPageLoadComplete(driver)
			BaseTest.test.get.info("Added in to excel sheet>>> " + row.rowNum +repoURL)
			
			}catch(Exception e){
				row.createCell(0).setCellValue(i);
				row.createCell(1).setCellValue("Clone button is not there");
				var FileOutputStream out = new FileOutputStream(new File(excelPath))
				wb.write(out)
				out.close()
				driver.navigate.back
				waitForPageLoadComplete(driver)
				BaseTest.test.get.fail("Clone button is not there>>> " + row.rowNum)
			}
		}					
	}
	
}
