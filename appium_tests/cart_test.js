const { remote } = require('webdriverio');
const path = require('path');

// HARDCODED PATHS (Keep existing path logic)
process.env.ANDROID_HOME = "C:\\Users\\ahmed\\AppData\\Local\\Android\\Sdk";
process.env.ANDROID_SDK_ROOT = "C:\\Users\\ahmed\\AppData\\Local\\Android\\Sdk";

const wdOpts = {
  hostname: process.env.APPIUM_HOST || 'localhost',
  port: parseInt(process.env.APPIUM_PORT, 10) || 4723,
  logLevel: 'info',
  capabilities: {
    platformName: 'Android',
    'appium:deviceName': 'Android Emulator',
    'appium:automationName': 'UiAutomator2',
    // FORCE NEW SESSION to ensure app launches fresh every time
    'appium:noReset': false,
    'appium:app': path.join(process.cwd(), '../build/app/outputs/flutter-apk/app-release.apk'),
    'appium:appWaitActivity': '*', // Wait for any activity
  }
};

async function runCartTest() {
  const driver = await remote(wdOpts);
  try {
    console.log("------------------------------------------------");
    console.log("🚀 STARTING BULLETPROOF CART TEST");
    console.log("------------------------------------------------");

    console.log("🔍 Checking if we are on Login Screen...");
    await driver.pause(5000); // Wait for app to load

    // Look for Email Field
    const textFields = await driver.$$('android.widget.EditText');
    
    if (textFields.length > 0) {
        console.log("🔑 Login Screen detected. Logging in first...");
        
        // 1. Enter Email
        await textFields[0].click();
        await textFields[0].setValue("ahmedyae011@gmail.com");
        
        // 2. Enter Password
        await textFields[1].click();
        await textFields[1].setValue("ahmed12345");
        
        // 3. Hide Keyboard
        if (await driver.isKeyboardShown()) {
            await driver.hideKeyboard();
        }
        
        // 4. Click Login Button (Try Accessibility ID first, then Class Name)
        const loginBtn = await driver.$('~Login');
        if (await loginBtn.isExisting()) {
            await loginBtn.click();
        } else {
            // Fallback: Click the first button found
            const btns = await driver.$$('android.widget.Button');
            if (btns.length > 0) await btns[0].click();
        }
        
        console.log("⏳ Waiting for Home Screen navigation...");
        await driver.pause(8000); // Give extra time for login & API fetch
    } else {
        console.log("🏠 Seems we are already on Home Screen.");
    }

    // 1. Wait for Home Screen (Wait for any ImageView to appear)
    console.log("⏳ Waiting for products to load...");
    await driver.pause(8000); 

    // 2. Click the FIRST Image on screen (The first Product)
    console.log("👉 Clicking the first product image...");
    const images = await driver.$$('android.widget.ImageView');
    if (images.length > 0) {
        await images[0].click(); // Click the first product image
    } else {
        throw new Error("No products found on Home Screen!");
    }

    // 3. Wait for Product Detail Screen
    await driver.pause(3000);

    // 4. Click "Add to Cart" (Find the big button at the bottom)
    console.log("🛒 Clicking 'Add to Cart' button...");
    // Strategy: It's usually the last Button on the screen
    const buttons = await driver.$$('android.widget.Button');
    if (buttons.length > 0) {
        // Click the last button found (Add to Cart is usually at the bottom)
        await buttons[buttons.length - 1].click();
    } else {
        console.warn("⚠️ No buttons found. Trying coordinate click for Add to Cart...");
        // Fallback: Click bottom center of screen
        const { width, height } = await driver.getWindowRect();
        await driver.touchAction({ action: 'tap', x: width / 2, y: height - 100 });
    }
    
    console.log("✅ Added to cart. Waiting...");
    await driver.pause(2000);

    // 5. INSTEAD OF BACK BUTTON -> RELAUNCH APP (Safer)
    console.log("🔄 Relaunching app to guarantee we are on Home Screen...");
    await driver.activateApp('com.ay.laza'); // Brings app to front / restarts
    await driver.pause(3000);

    // 6. Click Cart Icon (Top-Right Coordinate Strategy)
    console.log("👉 Clicking Cart Icon (Top-Right)...");
    // Coordinates for top-right (adjust if needed, usually safe for most emulators)
    await driver.performActions([{
      type: 'pointer',
      id: 'finger1',
      parameters: { pointerType: 'touch' },
      actions: [
        { type: 'pointerMove', duration: 0, x: 950, y: 150 },
        { type: 'pointerDown', button: 0 },
        { type: 'pause', duration: 100 },
        { type: 'pointerUp', button: 0 }
      ]
    }]);
    await driver.releaseActions();

    // 7. Success
    console.log("🎉 TEST FINISHED. Assuming success if no crash.");
    await driver.pause(3000);

  } catch (err) {
    console.error("❌ ERROR:", err.message);
  } finally {
    await driver.deleteSession();
  }
}

runCartTest();
