package com.chaoticneutral.frizider;

import android.os.Handler;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.MotionEvent;
import android.view.animation.Animation;
import android.view.animation.AnimationSet;
import android.view.animation.AnimationUtils;
import android.widget.LinearLayout;
import android.widget.TableLayout;
import android.widget.TextView;
import android.view.View;
import android.widget.Toast;

import com.chaoticneutral.frizider.utility.DecAnimation;
import com.chaoticneutral.frizider.utility.IncAnimation;

import java.util.Calendar;


public class RasporedActivity extends ActionBarActivity
{
    private LinearLayout linearLayoutLeft;
    private LinearLayout linearLayoutCenter;
    private LinearLayout linearLayoutRigth;

    private TextView textViewAddLeft;
    private TextView textViewAddCenter;
    private TextView textViewAddRight;

    private TextView textViewDayLeft;
    private TextView textViewDayCenter;
    private TextView textViewDayRight;

    private LinearLayout linearLayoutMain;

    Animation animLeftToRight;
    Animation animCenterToLeft;
    Animation animRightToCenter;

    Animation animLeftToCenter;
    Animation animCenterToRight;
    Animation animRightToLeft;

    private String[] arrayDays = {"Недеља", "Понедељак", "Уторак", "Среда", "Четвртак", "Петак", "Субота"};

    private float x1,x2;
    static final int MIN_DISTANCE = 150;

    private int day;

    private int swapNumber = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_raspored);

        linearLayoutLeft = (LinearLayout)findViewById(R.id.raspored_linearLayout_left);
        linearLayoutCenter = (LinearLayout)findViewById(R.id.raspored_linearLayout_center);
        linearLayoutRigth = (LinearLayout)findViewById(R.id.raspored_linearLayout_right);

        textViewAddLeft = (TextView)findViewById(R.id.raspored_textViewLeft_add);
        textViewAddCenter = (TextView)findViewById(R.id.raspored_textViewCenter_add);
        textViewAddRight = (TextView)findViewById(R.id.raspored_textViewRight_add);

        textViewAddLeft.setOnClickListener(addOnClick);
        textViewAddCenter.setOnClickListener(addOnClick);
        textViewAddRight.setOnClickListener(addOnClick);

        linearLayoutMain = (LinearLayout)findViewById(R.id.raspored_linearLayout_main);

        Calendar calendar = Calendar.getInstance();
        day = calendar.get(Calendar.DAY_OF_WEEK);

        textViewDayLeft = (TextView)findViewById(R.id.raspored_textView_left);
        textViewDayCenter = (TextView)findViewById(R.id.raspored_textView_center);
        textViewDayRight = (TextView)findViewById(R.id.raspored_textView_right);

        textViewDayLeft.setText(arrayDays[(day - 2) % 7]);
        textViewDayCenter.setText(arrayDays[(day - 1) % 7]);
        textViewDayRight.setText(arrayDays[day % 7]);
    }

    @Override
    public boolean onTouchEvent(MotionEvent event)
    {
        switch(event.getAction())
        {
            case MotionEvent.ACTION_DOWN:
                x1 = event.getX();
                break;
            case MotionEvent.ACTION_UP:
                x2 = event.getX();
                float deltaX = x2 - x1;
                if (deltaX < -MIN_DISTANCE)
                {
                    animLeftToRight = AnimationUtils.loadAnimation(getApplicationContext(), R.anim.left_to_right);
                    animCenterToLeft = AnimationUtils.loadAnimation(getApplicationContext(), R.anim.center_to_left);
                    animRightToCenter = AnimationUtils.loadAnimation(getApplicationContext(), R.anim.right_to_center);

                    IncAnimation animInc = new IncAnimation(linearLayoutRigth);
                    animInc.setDuration(800);

                    DecAnimation animDec = new DecAnimation(linearLayoutCenter);
                    animDec.setDuration(800);

                    AnimationSet animationSetRight = new AnimationSet(true);
                    animationSetRight.addAnimation(animInc);
                    animationSetRight.addAnimation(animRightToCenter);
                    animationSetRight.setFillAfter(true);

                    AnimationSet animationSetCenter = new AnimationSet(true);
                    animationSetCenter.addAnimation(animDec);
                    animationSetCenter.addAnimation(animCenterToLeft);
                    animationSetCenter.setFillAfter(true);

                    linearLayoutLeft.startAnimation(animLeftToRight);
                    linearLayoutCenter.startAnimation(animationSetCenter);
                    linearLayoutRigth.startAnimation(animationSetRight);

                    linearLayoutMain.removeAllViews();

                    LinearLayout pom = linearLayoutLeft;
                    linearLayoutLeft = linearLayoutCenter;
                    linearLayoutCenter = linearLayoutRigth;
                    linearLayoutRigth = pom;

                    linearLayoutMain.addView(linearLayoutLeft);
                    linearLayoutMain.addView(linearLayoutCenter);
                    linearLayoutMain.addView(linearLayoutRigth);

                    day++;
                    swapNumber++;
                    if (swapNumber == 3)
                    {
                        swapNumber = 0;
                    }

                    if (swapNumber == 0)
                    {
                        textViewDayLeft.setText(arrayDays[(day - 2) % 7]);
                        textViewDayCenter.setText(arrayDays[(day - 1) % 7]);
                        textViewDayRight.setText(arrayDays[day % 7]);
                    }
                    else if (swapNumber == 1)
                    {
                        textViewDayCenter.setText(arrayDays[(day - 2) % 7]);
                        textViewDayRight.setText(arrayDays[(day - 1) % 7]);
                        textViewDayLeft.setText(arrayDays[day % 7]);
                    }
                    else if (swapNumber == 2)
                    {
                        textViewDayRight.setText(arrayDays[(day - 2) % 7]);
                        textViewDayLeft.setText(arrayDays[(day - 1) % 7]);
                        textViewDayCenter.setText(arrayDays[day % 7]);
                    }
                }
                else if (deltaX > MIN_DISTANCE)
                {
                    animLeftToCenter = AnimationUtils.loadAnimation(getApplicationContext(), R.anim.left_to_center);
                    animCenterToRight = AnimationUtils.loadAnimation(getApplicationContext(), R.anim.center_to_right);
                    animRightToLeft = AnimationUtils.loadAnimation(getApplicationContext(), R.anim.right_to_left);

                    IncAnimation animInc = new IncAnimation(linearLayoutLeft);
                    animInc.setDuration(800);

                    DecAnimation animDec = new DecAnimation(linearLayoutCenter);
                    animDec.setDuration(800);

                    AnimationSet animationSetLeft = new AnimationSet(true);
                    animationSetLeft.addAnimation(animInc);
                    animationSetLeft.addAnimation(animLeftToCenter);
                    animationSetLeft.setFillAfter(true);

                    AnimationSet animationSetCenter = new AnimationSet(true);
                    animationSetCenter.addAnimation(animDec);
                    animationSetCenter.addAnimation(animCenterToRight);
                    animationSetCenter.setFillAfter(true);

                    linearLayoutLeft.startAnimation(animationSetLeft);
                    linearLayoutCenter.startAnimation(animationSetCenter);
                    linearLayoutRigth.startAnimation(animRightToLeft);

                    linearLayoutMain.removeAllViews();

                    LinearLayout pom = linearLayoutRigth;
                    linearLayoutRigth = linearLayoutCenter;
                    linearLayoutCenter = linearLayoutLeft;
                    linearLayoutLeft = pom;

                    linearLayoutMain.addView(linearLayoutLeft);
                    linearLayoutMain.addView(linearLayoutCenter);
                    linearLayoutMain.addView(linearLayoutRigth);

                    day--;
                    swapNumber++;
                    if (swapNumber == 3)
                    {
                        swapNumber = 0;
                    }

                    if (swapNumber == 0)
                    {
                        textViewDayRight.setText(arrayDays[day % 7]);
                        textViewDayLeft.setText(arrayDays[(day - 1) % 7]);
                        textViewDayCenter.setText(arrayDays[(day - 2) % 7]);
                    }
                    else if (swapNumber == 1)
                    {
                        textViewDayRight.setText(arrayDays[day % 7]);
                        textViewDayLeft.setText(arrayDays[(day - 1) % 7]);
                        textViewDayCenter.setText(arrayDays[(day - 2) % 7]);
                    }
                    else if (swapNumber == 2)
                    {
                        textViewDayCenter.setText(arrayDays[day % 7]);
                        textViewDayLeft.setText(arrayDays[(day - 1) % 7]);
                        textViewDayRight.setText(arrayDays[(day - 2) % 7]);
                    }
                }
                break;
        }
        return super.onTouchEvent(event);
    }

    private View.OnClickListener addOnClick = new View.OnClickListener()
    {
        @Override
        public void onClick(View v)
        {
            Log.e("Tapnuo", "Srednji");
        }
    };
}
