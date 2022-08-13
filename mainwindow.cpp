#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QPushButton>
#include <QPlainTextEdit>
#include <QTime>
#include <QTimer>

// Constructor
// Initializes member variables,
// connects button signals to slots,
// and starts update timer.
MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow),
    watch(new Stopwatch())
{
    ui->setupUi(this);

                    //slot
    QObject::connect(ui->startStopButton, &QPushButton::clicked,
                     this, &MainWindow::startStopTimer);
    QObject::connect(ui->resetButton, &QPushButton::clicked,
                     this, &MainWindow::resetTimer);
                            //signal
    QTimer *timer = new QTimer(this);
    connect(timer, SIGNAL(timeout()), this, SLOT(update()));
    timer->start(10);
}

// Destructor
MainWindow::~MainWindow()
{
    delete ui;
    delete watch;
}

// Triggers when the "Start"/"Pause"/"Restart" button is clicked
// If the watch is running, it pauses it.
// If the watch is not running, it resumes/starts it.
void MainWindow::startStopTimer() {
    if(watch->isRunning()) {
        ui->startStopButton->setText("Restart");
        watch->pause();
    }
    else {
        ui->startStopButton->setText("Pause");
        watch->start();
    }
}

// Triggers when the "Reset" button is clicked
// Stops the watch, if it is running,
// and resets the "Pause"/"Restart" to "Start"
void MainWindow::resetTimer() {
    ui->startStopButton->setText("Start");
    ui->hundredthsText->setText("00");
    ui->secondsText->setText("00");
    ui->minutesText->setText("00");
    watch->reset();
}

// Triggers every 10 milliseconds (every hundredth of a second)
// Updates the time displayed on the stopwatch.
void MainWindow::update()
{
    if(watch->isRunning())
    {
        qint64 time = watch->getTime();
        int h = time / 1000 / 60 / 60;
        int m = (time / 1000 / 60) - (h * 60);
        int s = (time / 1000) - (m * 60);
        int ms = time - ( s + ( m + ( h * 60)) * 60) * 1000;
        int ms_dis = ms / 10;
        if(ms_dis < 10) {
            ui->hundredthsText->setText(QStringLiteral("0%1").arg(ms_dis));
        }
        else {
            ui->hundredthsText->setText(QStringLiteral("%1").arg(ms_dis));
        }
        if(s < 10) {
            ui->secondsText->setText(QStringLiteral("0%1").arg(s));
        }
        else {
            ui->secondsText->setText(QStringLiteral("%1").arg(s));
        }
        if(m < 10) {
            ui->minutesText->setText(QStringLiteral("0%1").arg(m));
        }
        else {
            ui->minutesText->setText(QStringLiteral("%1").arg(m));
        }
    }
}
