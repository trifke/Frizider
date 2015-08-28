package com.chaoticneutral.frizider.utility;

import android.util.Log;
import android.view.animation.Animation;
import android.view.animation.Transformation;
import android.widget.LinearLayout;

/**
 * Created by software-nation on 6/18/15.
 */
public class DecAnimation extends Animation
{
    private int mWidth;
    private int mHeight;
    private int mStartWidth;
    private int mStartHeight;
    private LinearLayout mLinearLayout;

    public DecAnimation(LinearLayout linearLayout)
    {
        mLinearLayout = linearLayout;
        mStartWidth = linearLayout.getWidth();
        mStartHeight = linearLayout.getHeight();
        mWidth = mStartWidth;
        mHeight = mStartHeight / 4;
    }

    @Override
    protected void applyTransformation(float interpolatedTime, Transformation t)
    {
        int newWidth = mStartWidth + (int) ((mWidth - mStartWidth) * interpolatedTime);
        int newHeight = mStartHeight + (int) ((mHeight - mStartHeight) * interpolatedTime);

        float newWeight = 2 + (1 - 2) * interpolatedTime;

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
