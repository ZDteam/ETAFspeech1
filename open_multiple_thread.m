function open_multiple_thread()
    if ( matlabpool('size') == 0 ) 
        matlabpool
    end
end