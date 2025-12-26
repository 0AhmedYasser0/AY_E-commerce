/**
 * Appium Test: Cart Test
 * Scenario: Click first product on Home Screen -> Click "Add to Cart" -> Click Back -> Click Cart Icon -> Verify item count is 1
 * 
 * Prerequisites:
 * - Appium server running on localhost:4723
 * - Android emulator or device connected
 * - App APK installed or path configured
 * - User must be logged in (run auth_test.js first or login manually)
 */

const { remote } = require('webdriverio');

async function testCart() {
    console.log('Starting Cart Test...\n');

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
            'appium:noReset': true // Keep app state (user should be logged in)
        }
    };

    let driver;

    try {
        // Initialize driver
        driver = await remote(opts);
        console.log('Waiting for Home Screen to load...');
        await driver.pause(3000);

        // Step 1: Click first product on Home Screen
        console.log('✓ Step 1: Clicking first product...');
        // REPLACE WITH YOUR PRODUCT ELEMENT ID
        // Using xpath to find first product (products have keys like 'product_1', 'product_2', etc.)
        const firstProduct = await driver.$('//*[contains(@content-desc, "product_")]');
        await firstProduct.waitForDisplayed({ timeout: 10000 });
        await firstProduct.click();
        await driver.pause(2000);

        // Step 2: Click "Add to Cart"
        console.log('✓ Step 2: Clicking Add to Cart button...');
        // Using accessibility id strategy (Flutter Key: 'add_to_cart_button')
        const addToCartButton = await driver.$('~add_to_cart_button');
        await addToCartButton.waitForDisplayed({ timeout: 10000 });
        await addToCartButton.click();
        await driver.pause(2000);

        // Step 3: Click Back
        console.log('✓ Step 3: Going back to Home Screen...');
        await driver.back();
        await driver.pause(1000);

        // Step 4: Click Cart Icon
        console.log('✓ Step 4: Clicking Cart Icon...');
        // REPLACE WITH YOUR CART ICON ELEMENT ID
        const cartIcon = await driver.$('~cart_icon');
        await cartIcon.waitForDisplayed({ timeout: 10000 });
        await cartIcon.click();
        await driver.pause(2000);

        // Step 5: Verify item count is 1
        console.log('✓ Step 5: Verifying item count...');
        // REPLACE WITH YOUR CART ITEM ELEMENT ID
        // Using xpath to find cart items (cart items have keys like 'cart_item_1', etc.)
        const cartItem = await driver.$('//*[contains(@content-desc, "cart_item_")]');
        await cartItem.waitForDisplayed({ timeout: 10000 });

        if (await cartItem.isDisplayed()) {
            console.log('\n✅ Cart Test PASSED - Item found in cart!');
        } else {
            console.log('\n❌ Cart Test FAILED - No item found in cart');
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
testCart();
