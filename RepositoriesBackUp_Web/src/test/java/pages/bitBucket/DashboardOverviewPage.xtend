package pages.bitBucket

import org.openqa.selenium.WebElement
import org.openqa.selenium.remote.RemoteWebDriver
import org.openqa.selenium.support.FindBy
import org.openqa.selenium.support.How
import pages.BasePage

class DashboardOverviewPage extends BasePage {

	new(RemoteWebDriver driver) {
		super(driver)

	}

	@FindBy(how=How.XPATH, using="//span[text()='View all repositories']/..")
	public WebElement link_viewAllRepos;
	
	@FindBy(how=How.XPATH, using="//div[@id='repositories-filter-container']")
	public WebElement txt_filterContainers;
	

}
