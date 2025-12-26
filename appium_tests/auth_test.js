/**
 * Appium Test: Authentication Test
 * Scenario: Open App -> Enter Email -> Enter Password -> Click Login -> Verify User is on Home Screen
 * 
 * Prerequisites:
 * - Appium server running on localhost:4723
 * - Android emulator or device connected
 * - App APK installed or path configured
 */

process.env.ANDROID_HOME = "C:\\Users\\ahmed\\AppData\\Local\\Android\\Sdk";
process.env.ANDROID_SDK_ROOT = "C:\\Users\\ahmed\\AppData\\Local\\Android\\Sdk";
const path = require('path');

const { remote } = require('webdriverio');

async function testAuthentication() {
    console.log('Starting Authentication Test...\n');

    // Setup WebDriverIO options
    const opts = {
        hostname: 'localhost',
        port: 4723,
        path: '/',
        capabilities: {
            platformName: 'Android',
            'appium:deviceName': 'Android Emulator', // REPLACE WITH YOUR DEVICE NAME IF NEEDED
            'appium:app': path.join(process.cwd(), '../build/app/outputs/flutter-apk/app-release.apk'),
            'appium:automationName': 'UiAutomator2',
            'appium:noReset': false
        }
    };

    let driver;

    try {
        // Initialize driver
        driver = await remote(opts);
        console.log("✓ Step 1: App opened successfully");

        // PAUSE to let animations finish (important)
        await driver.pause(5000);

        // STRATEGY: Find all Text Fields (EditText)
        // The first one is usually Email, the second is Password.
        const textFields = await driver.$$('android.widget.EditText');
        
        if (textFields.length < 2) {
            console.log("⚠️ Could not find 2 text fields. Checking if we are already logged in...");
            // Optional: Add logout logic here if needed, or just fail with a clear message.
            throw new Error("Could not find Email/Password fields. Are you already logged in?");
        }

        console.log("✓ Found text fields. Entering credentials...");
        
        // Enter Email (First Field)
        await textFields[0].click();
        await textFields[0].setValue("ahmedyae011@gmail.com"); 
        
        // Enter Password (Second Field)
        await textFields[1].click();
        await textFields[1].setValue("ahmed12345");
        
        // Hide keyboard to see the Login button
        if (await driver.isKeyboardShown()) {
            await driver.hideKeyboard();
        }

        console.log("✓ Searching for Login button by accessibility id 'Login'...");
        
        // According to the XML source, the Login button has content-desc="Login"
        // So we can use the accessibility id selector directly.
        const loginBtn = await driver.$('~Login');
        
        // Wait for it to be clickable
        await loginBtn.waitForExist({ timeout: 5000 });
        
        console.log("✓ Found Login button. Clicking...");
        await loginBtn.click();
        
        console.log("✓ Clicked. Waiting for Home Screen navigation...");
        await driver.pause(5000);

        // Verify we reached the home screen (you can adjust this validation)
        console.log("✓ Verifying home screen...");
        const pageSource = await driver.getPageSource();
        
        // Simple validation: check if we're no longer on login screen
        if (!pageSource.includes("Welcome Back") && !pageSource.includes("Email Address")) {
            console.log('\n✅ Authentication Test PASSED - User is on Home Screen!');
        } else {
            console.log('\n❌ Authentication Test FAILED - Still on Login Screen');
        }

    } catch (error) {
        console.error(`\n❌ Test failed with error: ${error.message}`);
    } finally {
        if (driver) {
            await driver.deleteSession();
        }
    }
}

// Run the test
testAuthentication();
