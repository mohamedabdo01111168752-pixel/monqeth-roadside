# منقذ — تطبيق Android

مشروع Android أصلي صغير يعرض الموقع من ملفات محلية داخل WebView؛ لذلك يعمل المحتوى والتنسيق دون اتصال بالإنترنت. تفتح روابط الاتصال وواتساب في التطبيقات المناسبة على الهاتف.

## بناء APK تجريبي على Windows

المتطلبات: Node.js، وJava 17، وAndroid SDK مع Android SDK Platform 35 وBuild Tools 35.0.0.

```powershell
powershell -ExecutionPolicy Bypass -File .\build-android.ps1
```

ينتج ملف التثبيت التجريبي هنا:

```text
app\build\outputs\apk\debug\app-debug.apk
```

ثبّت APK على هاتف Android للاختبار. للنشر على Google Play يلزم إنشاء مفتاح توقيع خاص وإعداد إصدار `release`؛ لا تضع مفتاح التوقيع أو كلمات مروره في المستودع.

## تحديث الموقع داخل التطبيق

عدّل `index.html` ثم أعد البناء. مهمة Gradle تنسخ الصفحة وملف `app.css` إلى أصول التطبيق قبل البناء. لإعادة توليد CSS بعد تعديل أصناف Tailwind:

```powershell
npm.cmd ci
npm.cmd run build:css
```

## إعدادات قابلة للتخصيص

- معرّف التطبيق: `com.monqeth.roadside` في `app\build.gradle`.
- رقم الاتصال ما زال رقمًا تجريبيًا بصيغة السعودية داخل روابط `tel:`؛ حدّثه إلى رقم الخدمة قبل التوزيع.
- روابط واتساب مهيأة على الرقم `+20 112 112 1031`.
- نسخة التطبيق الحالية واجهة طلب ومعلومات. الطلب الفعلي والتتبع الحي يحتاجان إلى تطبيق خلفي وخدمات تشغيلية.

## نشر الموقع مجانًا على GitHub Pages

المستودع العام: https://github.com/mohamedabdo01111168752-pixel/monqeth-roadside

يوجد سير عمل GitHub Actions في `.github/workflows/pages.yml`. ينشر ملفات الموقع فقط (`index.html` و`app.css`) بعد بناء CSS، ولا ينشر ملفات APK أو مفاتيح التوقيع. من إعدادات المستودع افتح **Settings → Pages** واختر **GitHub Actions** كمصدر للنشر إذا لم يتم تفعيله تلقائيًا. بعد نجاح سير العمل، سيكون الموقع متاحًا على:

https://mohamedabdo01111168752-pixel.github.io/monqeth-roadside/

كل تحديث يُدفع إلى `main` يعيد نشر الموقع تلقائيًا. الموقع عام؛ تأكد من صحة رقم الهاتف ومعلومات التواصل قبل نشره. رقم الاتصال في روابط `tel:` ما زال تجريبيًا.
