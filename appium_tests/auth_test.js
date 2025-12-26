/**
 * Appium Test: Authentication Test
 * Scenario: Open App -> Enter Email -> Enter Password -> Click Login -> Verify User is on Home Screen
 * 
 * Prerequisites:
 * - Appium server running on localhost:4723
 * - Android emulator or device connected
 * - App APK installed or path configured
 */

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
            'appium:app': './builds/apk/app-release.apk', // REPLACE WITH YOUR APK PATH
            'appium:automationName': 'UiAutomator2',
            'appium:noReset': false
        }
    };

    let driver;

    try {
        // Initialize driver
        driver = await remote(opts);
        console.log('✓ Step 1: App opened successfully');
        await driver.pause(2000);

        // Step 2: Enter Email
        console.log('✓ Step 2: Entering email...');
        // Using accessibility id strategy (Flutter Key: 'email_field')
        const emailField = await driver.$('~email_field');
        await emailField.waitForDisplayed({ timeout: 10000 });
        await emailField.setValue('test@example.com'); // REPLACE WITH YOUR TEST EMAIL

        // Step 3: Enter Password
        console.log('✓ Step 3: Entering password...');
        // Using accessibility id strategy (Flutter Key: 'password_field')
        const passwordField = await driver.$('~password_field');
        await passwordField.setValue('test123456'); // REPLACE WITH YOUR TEST PASSWORD

        // Step 4: Click Login
        console.log('✓ Step 4: Clicking login button...');
        // Using accessibility id strategy (Flutter Key: 'login_button')
        const loginButton = await driver.$('~login_button');
        await loginButton.click();
        await driver.pause(3000);

        // Step 5: Verify User is on Home Screen
        console.log('✓ Step 5: Verifying home screen...');
        // REPLACE WITH YOUR HOME SCREEN ELEMENT ID
        // Example: Check for search field or any unique home screen element
        const homeElement = await driver.$('~search_field');
        await homeElement.waitForDisplayed({ timeout: 20000 });

        if (await homeElement.isDisplayed()) {
            console.log('\n✅ Authentication Test PASSED - User is on Home Screen!');
        } else {
            console.log('\n❌ Authentication Test FAILED - Home Screen not found');
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
