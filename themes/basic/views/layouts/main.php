<?php
use yii\helpers\Html;
use yii\bootstrap\Nav;
use yii\bootstrap\NavBar;
use yii\widgets\Breadcrumbs;
use app\themes\basic\BasicThemeAppAsset;

/**
 * @var \yii\web\View $this
 * @var string $content
 */
BasicThemeAppAsset::register($this);
?>
<?php $this->beginPage() ?>
<!DOCTYPE html>
<html lang="<?= Yii::$app->language ?>">
<head>
    <meta charset="<?= Yii::$app->charset ?>"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><?= Html::encode($this->title) ?></title>
    <?php $this->head() ?>
    
    <link rel="icon" type="image/x-icon" href="<?= Yii::getAlias('@web') ?>/favicon.ico" />
</head>
<body>

<?php $this->beginBody() ?>
    <div class="wrap">
        <?php
            NavBar::begin([
                'brandLabel' => 'Alba 2',
                'brandUrl' => Yii::$app->homeUrl,
                'options' => [
                    'class' => 'navbar-inverse navbar-fixed-top',
                ],
            ]);
            
            /*
            echo Nav::widget([
                'options' => ['class' => 'navbar-nav navbar-right'],
                'items' => [
                    ['label' => 'Home', 'url' => ['/site/index']],
                    ['label' => 'About', 'url' => ['/site/about']],
                    ['label' => 'Contact', 'url' => ['/site/contact']],
                    Yii::$app->user->isGuest ?
                        ['label' => 'Login', 'url' => ['/site/login']] :
                        ['label' => 'Logout (' . Yii::$app->user->identity->username . ')',
                            'url' => ['/site/logout'],
                            'linkOptions' => ['data-method' => 'post']],
                ],
            ]);
            NavBar::end();
            */ 
            
            echo Nav::widget([
                'options' => ['class' => 'navbar-nav navbar-right'],
                'items' => [
                    ['label' => 'Administración', 'url' => ['/administracion/']],
                    ['label' => 'Acerca de', 'url' => ['/site/about']],
                    Yii::$app->user->isGuest ?
                        ['label' => 'Login', 'url' => ['/site/login']] :
                        ['label' => 'Logout (' . Yii::$app->user->identity->username . ')',
                            'url' => ['/site/logout'],
                            'linkOptions' => ['data-method' => 'post']],
                ],
            ]);
            NavBar::end();
        ?>

        <div class="container">
            <?= Breadcrumbs::widget([
                'links' => isset($this->params['breadcrumbs']) ? $this->params['breadcrumbs'] : [],
            ]) ?>
            <?= $content ?>
        </div>
    </div>
    <footer class="footer">
        <div class="container">
            <p class="pull-left">&copy; pressEnter <?= date('Y') ?></p>
            <p class="pull-right"><?= Yii::powered() ?></p>
        </div>
    </footer>

<?php $this->endBody() ?>
</body>
</html>
<?php $this->endPage() ?>
