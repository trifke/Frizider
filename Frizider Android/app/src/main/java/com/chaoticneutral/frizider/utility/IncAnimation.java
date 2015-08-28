package com.chaoticneutral.frizider.utility;

import android.view.View;
import android.view.animation.Animation;
import android.view.animation.Transformation;
import android.widget.LinearLayout;

/**
 * Created by software-nation on 6/18/15.
 */
public class IncAnimation extends Animation
{
    private int mWidth;
    private int mHeight;
    private int mStartWidth;
    private int mStartHeight;
    private LinearLayout mLinearLayout;

    public IncAnimation(LinearLayout linearLayout)
    {
        mLinearLayout = linearLayout;
        mStartWidth = linearLayout.getWidth();
        mStartHeight = linearLayout.getHeight();
        mWidth = mStartWidth;
        mHeight = 4 * mStartHeight;
    }

    @Override
    protected void applyTransformation(float interpolatedTime, Transformation t)
    {
        int newWidth = mStartWidth + (int) ((mWidth - mStartWidth) * interpolatedTime);
        int newHeight = mStartHeight + (int) ((mHeight - mStartHeight) * interpolatedTime);

        float newWeight = 1 + (2 - 1) * interpolatedTime;

//        mLinearLayout.getLayoutParams().width = newWidth;

        LinearLayout.LayoutParams params = (LinearLayout.LayoutParams) mLinearLayout.getLayoutParams();
        params.weight = newWeight;

        mLinearLayout.getLayoutParams().height = newHeight;
        mLinearLayout.requestLayout();
    }

    @Override
    public void initialize(int width, int height, int parentWidth, int parentHeight)
    {
        super.initialize(width, height, parentWidth, parentHeight);
    }

    @Override
    public boolean willChangeBounds()
    {
        return true;
    }
}
