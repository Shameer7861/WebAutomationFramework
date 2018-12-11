package pages.bitBucket

import java.util.List
import org.openqa.selenium.WebElement
import org.openqa.selenium.remote.RemoteWebDriver
import org.openqa.selenium.support.FindBy
import org.openqa.selenium.support.How
import pages.BasePage

class DashboardRepoPage extends BasePage {

	new(RemoteWebDriver driver) {
		super(driver)

	}

	@FindBy(how=How.XPATH, using="//table[@class='aui repo-list iterable-list']//a[@class='execute repo-list--repo-name']")
	public List<WebElement> link_allRepos;
	
	@FindBy(how=How.XPATH, using="//span[text()='Clone']/ancestor::button")
	public WebElement btn_clone;
	
	@FindBy(how=How.XPATH, using="//span[text()='Clone this repository']/ancestor::div[1]/../following-sibling::div//input")
	public WebElement txt_cloneRepoUrl;
	
	@FindBy(how=How.XPATH, using="//span[text()='Close']/ancestor::button")
	public WebElement btn_closeRepo;
	
	
	
	

}
